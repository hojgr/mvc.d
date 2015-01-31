import v = vibe.d;
import std.stdio;
import index_controller;
import controller;
import std.conv;
import router;
import annotation;

template assignRoutes(alias ctrl) {
    alias ControllerType = typeof(ctrl);
    Router eval(Router router) {
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

    assignRoutes!(index).eval(router);

    v.listenHTTP(settings, router);
    v.runEventLoop();
}
