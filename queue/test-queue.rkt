;#lang racket/base

(require rackunit)

(define queue-tests
  (test-suite
    "Tests for the Queue"

    (test-case "Initial Queue Properties"
    (let  ((q (make-queue)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (check-equal? (dequeue q) null "Dequeing from an empty queue should return null.")
      (check-equal? (size q) 0 "Dequeing from an empty queue should leave size as zero.")
      ))
    
    (test-case "One Element Queue --- Functional Test"
    (let ((q (make-queue)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (enqueue q 10)
      (check-equal? (size q) 1 "One element should be added.")
      (check-equal? (top q) 10 "Look at the element.")
      (dequeue q)
      (check-equal? (size q) 0 "Queue should now have size zero.")
      (check-equal? (dequeue q) null "Dequeing from an empty queue should return null.")
      ))
    
    (test-case "One Element Queue --- Internal Test"
    (let ((q (make-queue)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (enqueue q 10)
      (check-equal? (size q) 1 "One element should be added.")
      (check-equal? (queue-back q) '(10) "The element should be in the back list.")
      (check-equal? (top q) 10 "Look at the element.")
      (check-equal? (queue-back q) '() "The element should not be in the back list.")
      (dequeue q)
      (check-equal? (size q) 0 "Queue should now have size zero.")
      (check-equal? (queue-back q) '() "The back queue must be empty.")
      (check-equal? (queue-front q) '() "The front queue must still be empty.")
      ))
    
    (test-case "Multi Element Queue --- Functional Test"
    (let ((q (make-queue)) (elts (list 8 6 7 5 3 0 9)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (for ((i elts)
            (num (in-range 1 8)))
        (enqueue q i)
        (check-equal? (size q) num "One element should be added.")
        (check-equal? (top q) 8 "Top should remain the same")
        )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
        (check-equal? (top q) (list-ref elts (- (length elts) num)) "Look at the elements being subtracted.")
        (dequeue q)
        (check-equal? (size q) (- num 1) "One element should be subtracted.")
        )
     ))
    
    (test-case "Multi Element Queue --- Ebb and Flow Test"
    (let ((q (make-queue)) (elts (list 8 6 7 5 3 0 9)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (for ((i elts)
            (num (in-range 1 8)))
        (enqueue q i)
        (check-equal? (size q) num "One element should be added; first flow.")
        (check-equal? (top q) 8 "Top should remain the same")
        )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
        (check-equal? (top q) (list-ref elts (- (length elts) num)) "Look at the elements being subtracted.")
        (dequeue q)
        (check-equal? (size q) (- num 1) "One element should be subtracted; first ebb.")
        )
      (for ((i elts)
            (num (in-range 1 8)))
        (enqueue q i)
        (check-equal? (size q) num "One element should be added; second flow.")
        (check-equal? (top q) 8 "Top should remain the same")
        )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
        (check-equal? (top q) (list-ref elts (- (length elts) num)) "Look at the elements being subtracted.")
        (dequeue q)
        (check-equal? (size q) (- num 1) "One element should be subtracted; second ebb.")
        )
      ))
    
    (test-case "Multi Element stack --- Internal Test"
    (let ((q (make-queue)) (elts (list 5 8 8 2 3 0 0)) (tmp null))
      (for ((i elts)
            (num (in-range 1 8)))
        (enqueue q i)
        (check-equal? (size q) num "One element should be added.")
        (set! tmp (cons i tmp)) ;"Enqueue" element to list
        (check-equal? (queue-back q) tmp "Queue back list is in correct form")
        )
      ))
))
