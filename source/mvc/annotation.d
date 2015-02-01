module mvc.annotation;

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

unittest { 
    /* Tests function annotated with an instance of int */
    @(1)
    void i_annotatedTestFunc() {}
    void i_nonAnnotatedTestFunc() {}

    assert(hasAnnotation!(i_annotatedTestFunc, int));
    assert(!hasAnnotation!(i_nonAnnotatedTestFunc, int));


    /* Tests function annotated with an enum type */
    enum EAnnotation;

    @EAnnotation
    void annotatedTestFunc() {}
    void nonAnnotatedTestFunc() {}

    assert(hasAnnotation!(annotatedTestFunc, EAnnotation));
    assert(!hasAnnotation!(nonAnnotatedTestFunc, EAnnotation));

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

unittest {
    @(1)
    void i_annotatedTestFunc() {}

    assert(getAnnotation!(i_annotatedTestFunc, int) == 1);

    struct SAnnot { int num; }

    @SAnnot(2)
    void s_annotatedTestFunc() {}

    assert(getAnnotation!(s_annotatedTestFunc, SAnnot).num == 2);
}
