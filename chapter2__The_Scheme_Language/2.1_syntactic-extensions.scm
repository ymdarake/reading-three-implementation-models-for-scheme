# record
# kind of destructuring and then applying
# binds a set of variables to the elements of a list
# (this list, or record, must contain as many elements as there are variables; the variables name the fields of the record).
# This syntactic extension uses the apply function described earlier,
# which applies a function to a list of arguments:
#
# (record (var ...) val exp ...)
# →
# (apply (lambda (var ...) exp ...) val)
#
# The following function uses record to help reverse a list of three elements:

(lambda (3-element-list)
    (record (a b c) 3-element-list
        (list c b a)))

# record-case
# is a special purpose combination of cond and record.
# It is useful for destructuring a record based on the “key” that appears as the record’s first element:
#
# (record-case exp1
#     [key vars exp2 ...]
#     [else exp3 ...])
# →
# (let ([r exp1])
#     (cond
#         [(eq? (car r) ’key)
#        (record vars (cdr r) exp2 . . . )]
#        [else exp3 . . . ]))
# The variable r is introduced so that exp is only evaluated once.
# Care must be taken to prevent r from capturing any free variables
# as mentioned above in the description of the begin syntactic extension.
# record-case is convenient for parsing an expression

(rec calc
    (lambda (x)
        (if (integer? x)
            x
            (record-case x
                (+ (x y) (+ (calc x) (calc y)))
                (* (x y) (* (calc x) (calc y)))
                (- (x) (- 0 (calc x)))
                (else (error "invalid expression"))))))
