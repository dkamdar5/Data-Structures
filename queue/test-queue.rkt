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
    
    (test-case "One Element Queue ---Functional Test"
    (let ((q (make-queue)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      (enqueue q 10)
      (check-equal? (size q) 1 "One element should be added.")
      (check-equal? (top q) 10 "Look at the element.")
      (dequeue q)
      (check-equal? (size q) 0 "Queue should now have size zero.")
      (check-equal? (dequeue q) null "Dequeing from an empty queue should return null")
      ))
    
    ))
