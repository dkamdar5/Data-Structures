(module stack racket
  (provide make-stack push pop top size stack-tests)
  (struct stack (data size) #:mutable)

  (define (make-stack) (stack null 0))

  (define (push s elt)
    (set-stack-size! s (+ (stack-size s) 1))
    (set-stack-data! s (cons elt (stack-data s)))
    )

  (define (top s)
    (if (null? (stack-data s))
      null
      (car (stack-data s))))

  (define (size s)
    (stack-size s))

  (define (pop s)
    (if (null? (stack-data s)) null
      (begin
    ;    (set-stack-size! s (- (stack-size s) 1))  ; oh no! a bug!
        (set-stack-data! s (cdr (stack-data s)))
        )))

  ; Test cases here
  (include "test-stack.rkt")
  )
