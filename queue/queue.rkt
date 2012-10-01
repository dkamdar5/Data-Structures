(module queue racket
  (provide make-queue enqueue dequeue top size queue-tests)
  (struct queue (front back size) #:mutable)

  ; Your Code Here
  (define (make-queue) (queue null null 0))
  
  (define (enqueue q elt)
    (set-queue-size! q (+ (queue-size q) 1))
    (set-queue-front! q (cons elt (queue-front q))))
  
  (define (dequeue q)
     (if (and (null? (queue-front q)) (null? (queue-back q))) null
         (if (null? (queue-back q))
             (begin
               (set-queue-back! q (cdr (reverse (queue-front q))))
               (set-queue-front! q null)
               (set-queue-size! q (- (queue-size q) 1)))
             (begin
               (set-queue-back! q (cdr (queue-back q)))
               (set-queue-size! q (- (queue-size q) 1))))))
  
  (define (top q)
    (if (and (null? (queue-front q)) (null? (queue-back q))) null
        (if (null? (queue-back q)) (last (queue-front q))
              (car (queue-back q)))))
  
  (define (size q)
    (queue-size q))
  
  (define (reverse xx)
  (define (aux x y)
    (cond ((null? x) y)
          (else (aux (cdr x) (cons (car x) y)))))
  (aux xx null))


  ; Test cases Here
  (include "test-queue.rkt")
)
