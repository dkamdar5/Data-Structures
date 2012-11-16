;#lang racket/base

(require rackunit)

(define bst-tests
  (test-suite
    "Tests for the bst"

    (test-case "Initial BST Properties"
    (let  ((bst (make-bst <)))
      (check-equal? (size bst) 0 "tree initially should have size zero.")
      (define newbst (delete bst 1))
      (check-equal? (size bst) 0 "tree should have size zero.")
      (define newbst(add newbst 1 'one))
      (check-equal? (size bst) 1 "increment size")
      (define newbst (delete newbst 1))
      (check-equal? (size bst) 0 "decrement size")
      ))
    
    (test-case "One Element BST --- Functional Test"
     (let ((bst (make-bst <)))
       (check-equal? (bst-size bst) 0 "Initial size")
       (define newbst (add bst 1 'one))
       (check-equal? (bst-size bst) 1 "Increment size")
       (define newbst (delete newbst 1))
       (check-equal? (bst-size bst) 0 "Decrement size")
     ))
))

