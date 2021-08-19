# The Scheme Language

1. Lexical scoping
     - the body of code, or scope, in which a variable is visible depends only upon the structure of the code and not upon the dynamic nature of the computation (as with dynamic scoping, which is employed by many Lisp dialects).
2. Block structure
    - scopes may be nested (in blocks); any statement (or expression, in Scheme) can introduce a new block with its own local variables that are visible only within that block.
3. applicative order language
     - meaning that the subexpressions of a function application, i.e., the function and argument expressions, are always evaluated before the application is performed.
        - In contrast, in Algol 60, evaluation of an argument passed by name does not occur until the argument is used.
4. first-class functions, or closures
    - A closure is an object that combines the function with the lexical bindings of its free variables at the time it is created.
    - Closures are first class data objects because they may be
        - passed as arguments to
        - or returned as values from other functions
        - or stored in the system indefinitely.
5. first-class continuations
    - A continuation is a Scheme function that embodies “the rest of the computation.”
        - The continuation of any Scheme expression (one exists for each, waiting for its value) determines what is to be done with its value.
        - This continuation is always present, in any language implementation, since the system is able to continue from each point of the computation.
    - Scheme simply provides a mechanism for obtaining this continuation as a closure.
    - The continuation, once obtained, can be used to continue, or restart, the computation from the point it was obtained, whether or not the computation has previously completed, i.e., whether or not the continuation has been used, explicitly or implicitly. 
    - This is useful for nonlocal exits in handling exceptions, or in the implementation of complex control structures such as coroutines or tasks.