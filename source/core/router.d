import v = vibe.d;
import std.stdio;
import annotation;

struct Route { 
    string path;
}

class Router : v.HTTPServerRequestHandler {
    void delegate()[string] routes;

    void get(string path, void delegate() func) {
        assert(path !in routes, "Route " ~ path ~ " is already defined!");
        writeln("Adding route " ~ path);
        routes[path] = func;
    }

    void handleRequest(v.HTTPServerRequest req, v.HTTPServerResponse res) {
        if(req.path !in routes) {
            writeln("404 - Path " ~ req.path ~ " not defined!");
        } else {
            routes[req.path]();
        }
    }


}

Router addRoutes(alias ctrl)(Router router) {
    alias ControllerType = typeof(ctrl);
    foreach(member; __traits(allMembers, ControllerType)) {
        static if(hasAnnotation!(__traits(getMember, ControllerType, member), Route) == true) {
            Route r = getAnnotation!(__traits(getMember, ctrl, member), Route);
            router.get(r.path, &__traits(getMember, ctrl, member));
        }
    }

    return router;
}
