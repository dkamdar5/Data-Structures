(module queue racket
  (provide make-queue enqueue dequeue top size queue-tests)
  (struct queue (front back size) #:mutable #:transparent)

  ; Your Code Here
  (define (make-queue) (queue null null 0))
  
  (define (enqueue q elt)
    (set-queue-size! q (+ (queue-size q) 1))
    (set-queue-back! q (cons elt (queue-back q))))
  
  (define (dequeue q)
     (if (and (null? (queue-front q)) (null? (queue-back q))) null
         (if (null? (queue-front q))
             (begin
               (back-to-front q)
               (set-queue-size! q (- (queue-size q) 1)))
             (begin
               (set-queue-front! q (cdr (queue-front q)))
               (set-queue-size! q (- (queue-size q) 1))))))
   
  (define (top q)
    (back-to-front q)
    (if (null? (queue-front q)) null
              (car (queue-front q))))
  
  (define (size q)
    (queue-size q))
  
  (define (back-to-front q)
    (set-queue-front! q (append (queue-front q) (reverse (queue-back q))))
    (set-queue-back! q null)
    )

  ; Test cases Here
  (include "test-queue.rkt")
)
