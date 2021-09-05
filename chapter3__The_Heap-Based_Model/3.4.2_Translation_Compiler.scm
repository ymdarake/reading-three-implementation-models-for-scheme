(define compile
  (lambda (x next)
    (cond
      [(symbol? x)
       (list 'refer x next)]
      [(pair? x)
       (record-case x
                    [quote (obj)
                           (list 'constant obj next)]
                    [lambda (vars body)
                      (list 'close vars (compile body '(return)) next)]
                    [if (test then else)
                        (let ([thenc (compile then next)]
                              [elsec (compile else next)])
                          (compile test (list 'test thenc elsec)))]
                    [set! (var x)
                          (compile x (list 'assign var next))]
                    [call/cc (x); x => lambda => 'close instruction
                             (let ([c (list 'conti; creates a continuation from the current stack, places this continuation in the accumulator. therefore the argument of x above will be this continuation and then applied in the step below
                                            (list 'argument
                                                  (compile x '(apply))))]); sets the next expression to x.
                               (if (tail? next)
                                   c
                                   (list 'frame next c)))]
                    [else
                     (recur loop ([args (cdr x)]
                                  [c (compile (car x) '(apply))]); this line is for the Final step
                       (if (null? args)
                           (if (tail? next)
                               c ; tail call optimization 
                               (list 'frame next c)); Final step of the apply instruction
                           (loop (cdr args)
                                 (compile (car args)
                                          (list 'argument c)))))])]
      [else
       (list 'constant x next)])))

(define tail?
  (lambda (next)
    (eq? (car next) 'return)))
