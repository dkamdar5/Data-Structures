;#lang racket/base

(require rackunit)

(define bst-tests
  (test-suite
    "Tests for the bst"

    (test-case "Initial BST Properties"
    (let  ((bst (make-bst <)))
      (check-equal? (size bst) 0 "tree initially should have size zero.")
      (delete bst 1)
      (check-equal? (size bst) 0 "tree should have size zero.")
      (add bst null '())
      (check-equal? (size bst) 0 "tree should have size zero.")
      (add bst 1 'one)
      (check-equal? (size bst) 1 "increment size")
      (check-equal? (bst-size bst) 1 "increment size")
      (delete bst 1)
      (check-equal? (size bst) 0 "decrement size")
      ))

))

