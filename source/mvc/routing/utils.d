module mvc.routing.utils;

import mvc.annotation;
import mvc.routing.router;
import mvc.routing.route;
import std.stdio;
import std.conv;

Router addRoutes(alias ctrl)(Router router) 
{
    alias ControllerType = typeof(ctrl);

    int validRouters = 0;

    foreach(member; __traits(allMembers, ControllerType)) 
    {
        static if(__traits(hasMember, ctrl, member)) {
            static if(hasAnnotation!(__traits(getMember, ctrl, member), Route) == true) 
            {
                Route r = getAnnotation!(__traits(getMember, ctrl, member), Route);
                router.get(r.path, &__traits(getMember, ctrl, member));
                validRouters++;
            }
        }
    }

    version(unittest) {} else {
        if(validRouters == 0) {
            writeln("Class '" ~ ControllerType.stringof ~ "' contains no routed methods");
        }
    }

    return router;
}

unittest {
    import dmocks.mocks;
    import mvc.controller;

    // test valid route addition
    {
        auto mocker = new Mocker();    

        class Ctrl : Controller 
        {
            @Route("/wat")
            string rt() { return "route"; }
        }

        Ctrl c = new Ctrl;
        Router router = mocker.mock!(Router);

        mocker.expect(router.get("/wat", &__traits(getMember, c, "rt")));

        mocker.replay();

        addRoutes!(c)(router);
        mocker.verify();
    }

    // test with empty class
    {
        auto mocker = new Mocker();
        class ECtrl : Controller {}

        ECtrl ec = new ECtrl;
        Router router = mocker.mock!(Router);
        
        mocker.replay();
        addRoutes!(ec)(router);
        mocker.verify();
    }
}
