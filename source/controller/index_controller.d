module blog.controller.index;

import std.stdio;
import mvc.controller;
import mvc.router;

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
