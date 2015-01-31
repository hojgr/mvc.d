import dependency;
import std.stdio;

class User 
{
    this(Dependency d) 
    {
        writeln("Dependency type: " ~ d.stringof);
    }
}
