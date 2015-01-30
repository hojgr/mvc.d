import v = vibe.d;
import std.stdio;

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

