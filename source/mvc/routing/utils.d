module mvc.routing.utils;

import mvc.annotation;
import mvc.routing.router;
import mvc.routing.route;

Router addRoutes(alias ctrl)(Router router) 
{
    alias ControllerType = typeof(ctrl);
    foreach(member; __traits(allMembers, ControllerType)) 
    {
        static if(hasAnnotation!(__traits(getMember, ControllerType, member), Route) == true) 
        {
            Route r = getAnnotation!(__traits(getMember, ctrl, member), Route);
            router.get(r.path, &__traits(getMember, ctrl, member));
        }
    }

    return router;
}
