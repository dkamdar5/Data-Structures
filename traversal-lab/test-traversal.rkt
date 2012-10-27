;#lang racket/base

(require rackunit)

(define traversal-tests
  (test-suite
    "Tests for the traversal lab"

    (test-case "Initial Properties"
    (let  ((bst (make-tree)))
      (check-equal? 1 0 "Student didn't write any tests.")
      ))

))

