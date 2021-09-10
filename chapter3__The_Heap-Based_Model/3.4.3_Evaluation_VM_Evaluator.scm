(define VM
    (lambda (a x e r s)
        (record-case x
            [halt () a]
            [refer (var x)
             (VM (car (lookup var e)) x e r s)]
            [constant (obj x)
             (VM obj x e r s)]
            [close (vars body x)
             (VM (closure body e vars) x e r s)]
            [test (then else)
             (VM a (if a then else) e r s)]
            [assign (var x)
             (set-car! (lookup var e) a)
             (VM a x e r s)]
            [conti (x)
             (VM (continuation s) x e r s)]
            [nuate (s var)
             (VM (car (lookup var e)) '(return) e r s)]
            [frame (ret x)
             (VM a x e '() (call-frame ret e r s))]
            [argument (x)
             (VM a x e (cons a r) s)]
            [apply ()
             (record a (body e vars)
                (VM a body (extend e vars r) '() s))]
            [return ()
             (record s (x e r s)
                (VM a x e r s))])))

(define lookup
    (lambda (var e)
        (recur nxtrib ([e e])
            (recur nxtelt ([vars (caar e)] [vals (cdar e)])
                (cond 
                  [(null? vars) (nxtrib (cdr e))]
                  [(eq? (car vars) var) vals]
                  [else (nxtelt (cdr vars) (cdr vals))])))))

(define closure
    (lambda (body e vars)
        (list body e vars)))

(define continuation
    (lambda (s) ; s for stack
        (closure (list 'nuate s 'v) '() '(v)))); one arg closure

(define call-frame
    (lambda (x e r s)
        (list x e r s)))

(define extend
    (lambda (e vars vals)
        (cons (cons vars vals) e)))

(define evaluate
    (lambda (x)
        (VM '() (compile x '(halt)) '() '() '())))
