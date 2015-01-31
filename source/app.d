import v = vibe.d;
import std.stdio;
import index_controller;
import controller;
import std.conv;
import router;
import annotation;



void main() {
    auto settings = new v.HTTPServerSettings;
    settings.bindAddresses = ["127.0.0.1"];
    settings.port = 8080;

    Router router = new Router;

    IndexController index = new IndexController;

    addRoutes!(index)(router);

    v.listenHTTP(settings, router);
    v.runEventLoop();
}
