module blog.controller.index_controller;

import std.stdio;
import mvc.controller;
import mvc.routing.route;

class IndexController : Controller 
{

    string x;
    string latest;

    this() 
    {
        x = "index";
    }

    @Route("/home")
    string home() 
    {
        string output = x ~ "->home ; latest: " ~ latest;
        latest = "home";

        return output;
    }

    @Route("/hell")
    string hellyeah() 
    {
        string output = x ~ "->hellya ; latest: " ~ latest;
        latest = "hell";

        return output;
    }

}
