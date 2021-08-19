# Introduction
- The heap-based model is well-known, having been employed in most Scheme implementations since Scheme’s introduction in 1975 [Sus75].
- The stack-based and string-based models are new, and are described here fully for the first time.
- The heap-based model requires the use of a heap to store call frames and variable bindings
- The stack-based and string-based models allow the use of a stack or string to hold the same information.
- The stack-based model avoids most of the heap allocation required by the heap-based model, reducing the amount of space and time required to execute most Scheme programs.
- The string-based model avoids both stack and heap allocation and facilitates concurrent evaluation of certain parts of a program.
- The stack-based model is intended for use on traditional single-processor computers
- The string-based model is intended for use on small-grain multiple-processor computers that execute programs by string reduction.
- The stack-based and string-based models support efficient Scheme implemen- tations partly because Scheme encourages functional rather than imperative programming techniques. That is, typical Scheme programs rely principally on functions and recursion rather than statements and loops, and they tend to use few variable assignments. Assignments are permitted, but they appear infrequently in Scheme code. The stack-based and string-based models exploit this, improving the speed of assignment-free code while possibly penalizing code that makes heavy use of assignments.
