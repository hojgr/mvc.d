import std.stdio;
import controller;
import router;

class IndexController : Controller 
{

    string x;
    string latest;

    this() 
    {
        x = "index";
    }

    @Route("/home")
    void home() 
    {
        writeln(x ~ "->home ; latest: " ~ latest);
        latest = "home";
    }

    @Route("/hell")
    void hellyeah() 
    {
        writeln(x ~ "->hellya ; latest: " ~ latest);
        latest = "hell";
    }

}
