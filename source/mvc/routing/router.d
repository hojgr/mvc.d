module mvc.routing.router;

import v = vibe.d;
import std.stdio;
import mvc.annotation;

class Router : v.HTTPServerRequestHandler 
{
    string delegate()[string] routes;

    void get(string path, string delegate() func) 
    {
        assert(path !in routes, "Route " ~ path ~ " is already defined!");
        writeln("Adding route " ~ path);
        routes[path] = func;
    }

    void handleRequest(v.HTTPServerRequest req, v.HTTPServerResponse res) 
    {
        if(req.path !in routes) 
        {
            writeln("404 - Path " ~ req.path ~ " not defined!");
        } else 
        {
            string output = routes[req.path]();
            res.writeBody(output);
        }
    }


}


