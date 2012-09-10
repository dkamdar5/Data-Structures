;#lang racket/base

(require rackunit)

(define queue-tests
  (test-suite
    "Tests for the Queue"

    (test-case "Initial Queue Properties"
    (let  ((q (make-queue)))
      (check-equal? (size q) 0 "Queue initially should have size zero.")
      ))

    ))

