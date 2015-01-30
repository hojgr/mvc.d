import v = vibe.d;
import std.stdio;
import index_controller;
import controller;
import std.conv;
import router;
import annotation;

template assignRoutes(ControllerType) {
    Router eval(ControllerType ctrl, Router router) {
        foreach(member; __traits(allMembers, ControllerType)) {
            static if(hasAnnotation!(__traits(getMember, ControllerType, member), Route) == true) {
                Route r = getAnnotation!(__traits(getMember, ctrl, member), Route);
                router.get(r.path, &__traits(getMember, ctrl, member));
            }
        }

        return router;
    }

}

void main() {
    auto settings = new v.HTTPServerSettings;
    settings.bindAddresses = ["127.0.0.1"];
    settings.port = 8080;
    
    Router router = new Router;

    IndexController index = new IndexController;

    assignRoutes!(typeof(index)).eval(index, router);
    /*
    foreach(member; __traits(allMembers, typeof(index))) {
        static if(hasAnnotation!(__traits(getMember, typeof(index), member), Route) == true) {
            Route r = getAnnotation!(__traits(getMember, index, member), Route);
            router.get(r.path, &__traits(getMember, index, member));
        }
    }
    */
    /*
    pragma(msg, __traits(getMember, typeof(index), "home"));
    assignRoutes!(typeof(index)).eval(router, router);
*/
    v.listenHTTP(settings, router);
    v.runEventLoop();
}
