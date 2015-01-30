import std.stdio;
import controller;
import router;

class IndexController : Controller {

    string x;

    this() {
        x = "index";
    }

    @Route("/home")
    void home() {
        writeln(x ~ "->home");
    }

    @Route("/hell")
    void hellyeah() {
        writeln(x ~ "->hellya");
    }

}
