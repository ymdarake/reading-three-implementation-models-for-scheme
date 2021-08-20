# More than one return function may be passed along to provide,
# for example, both “success” and “failure” returns.
# For example, integer-divide might return the error message "divide by zero" to a failure closure,
# freeing the caller from any explicit tests whatsoever:

(define integer-divide
    (lambda (x y success failure)
        (if (= y 0)
            (failure "divide by zero")
            (success (quotient x y) (remainder x y)))))

# The call:

(integer-divide 13 4 cons (lambda (x) x))

# returns (3 . 1), while:

(integer-divide 13 0 cons (lambda (x) x))

# returns "divide by zero".
# This technique of passing explicit return functions is called continuation- passing-style (CPS).
# This is similar to but not the same as the use of continuations discussed in Section 2.4.
# Here the continuation is explicitly created by the program, not obtained from the system with call/cc.


# To delay a computation until some future time,
# all that must be done is to create a closure with no arguments
# (often called a thunk, a term used to describe Algol 60 by-name parameters)
# and to apply this closure at some future time.
# This is a consequence of applicative order evaluation;
# the body of the function cannot be evaluated until (unless) the function is applied.

# (stream exp1 exp2)
# →
# (cons exp1 (lambda () exp2))

(define stream-ref
    (lambda (s n)
        (if (zero? n)
            (car s)
            (stream-ref ((cdr s)) (- n 1)))))
