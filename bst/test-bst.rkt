;#lang racket/base

(require rackunit)

(define bst-tests
  (test-suite
    "Tests for the bst"

    (test-case "Initial BST Properties"
    (let  ((a (make-bst <)))
      (check-equal? (size a) 0 "tree initially should have size zero.")
      (define b (delete a 1))
      (check-equal? (size a) 0 "tree should have size zero.")
      (check-equal? (size b) 0 "tree should have size zero.")
      (define c (add b 1 'one))
      (check-equal? (size a) 1 "increment size")
      (check-equal? (size b) 1 "increment size")
      (check-equal? (size c) 1 "increment size")
      (define d (delete c 1))
      (check-equal? (size a) 0 "decrement size")
      (check-equal? (size b) 0 "decrement size")
      (check-equal? (size c) 0 "decrement size")
      (check-equal? (size d) 0 "decrement size")
      ))
    
    (test-case "One Element BST --- Functional Test"
     (let ((a (make-bst <)))
       (check-equal? (bst-size a) 0 "Initial size")
       (define b (add a 1 'one))
       (check-equal? (bst-size a) 1 "Increment size")
       (check-equal? (bst-size b) 1 "Increment size")
       (define c (delete b 1))
       (check-equal? (bst-size a) 0 "Decrement size")
       (check-equal? (bst-size b) 0 "Decrement size")
       (check-equal? (bst-size c) 0 "Decrement size")
     ))
))

