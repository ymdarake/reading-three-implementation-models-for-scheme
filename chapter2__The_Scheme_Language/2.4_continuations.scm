# Inward continuations can easily produce infinite loops:

(let ([comeback (call/cc (lambda (c) c))])
    (comeback comeback))

# The call/cc expression creates a continuation and passes it to the closure created by (lambda (c) c).
# The closure simply returns this continuation, which then becomes the value of comeback.
# The application of this continuation to itself returns control to the call/cc with the continuation as its value (again).
# This results in comeback being bound to the continuation (again), and the whole process repeats forever.

# If the code were changed slightly so that the continuation is passed a different value, say 3:

(let ([comeback (call/cc (lambda (c) c))])
    (comeback 3))

# comeback would be bound to 3 the second time through and the program would abort with an error message,
# something like “attempt to apply nonclosure 3”.
# just like (3 3) will be aborted.

# The logical next step is to replace 3 with a closure, such as the identity closure (lambda (x) x):

(let ([comeback (call/cc (lambda (c) c))])
    (comeback (lambda (x) x)))

# Now, comeback will be bound to the identity closure the second time.
# This closure will be applied to the identity closure,
# which does not return control to the call/cc but rather simply returns its argument.
# So the above expression does terminate, and returns the identity closure.
# Incidentally, this expression may be simplified to:

((call/cc (lambda (c) c)) (lambda (x) x))

# and applied to a value of some sort:

(((call/cc (lambda (c) c)) (lambda (x) x)) 'HEY!)

