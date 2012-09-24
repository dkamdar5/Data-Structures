;#lang racket/base

(require rackunit)

(define dlist-tests
  (test-suite
    "Tests for the dlist"

    (test-case "Initial dlist Properties"
    (let  ((dl (make-dlist)))
      (check-equal? (size dl) 0 "list initially should have size zero.")
      ))

))

