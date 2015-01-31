template hasAnnotation(alias f, A) 
{
    static bool eval() 
    {
        foreach(a; __traits(getAttributes, f)) 
        {
            static if(is(a == A) || is(typeof(a) == A)) 
            {
                return true;
            }
        }

        return false;
    }

    enum bool hasAnnotation = eval();
}

template getAnnotation(alias f, A) 
{
    static A eval() 
    {
        foreach(a; __traits(getAttributes, f)) 
        {
            static if(is(typeof(a) == A)) 
            {
                return a;
            }
        }
        assert(0, "Class " ~ typeof(f).stringof ~ " doesnt have annotation " ~ A.stringof);
    }

    enum A getAnnotation = eval();
}
