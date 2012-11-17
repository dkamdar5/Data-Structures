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
      (check-equal? (size a) 0 "no changes")
      (check-equal? (size b) 0 "no change")
      (check-equal? (size c) 1 "increment size")
      (define d (delete c 1))
      (check-equal? (size a) 0 "no changes")
      (check-equal? (size b) 0 "no change")
      (check-equal? (size c) 1 "no change")
      (check-equal? (size d) 0 "decrement size")
      ))
    
    (test-case "One Element BST --- Functional Test"
     (let ((a (make-bst <)))
       (check-equal? (bst-size a) 0 "Initial size")
       (define b (add a 1 'one))
       (check-equal? (bst-size a) 0 "No change")
       (check-equal? (bst-size b) 1 "Increment size")
       (define c (delete b 1))
       (check-equal? (bst-size a) 0 "No change")
       (check-equal? (bst-size b) 1 "No change")
       (check-equal? (bst-size c) 0 "Decrement size")
     ))
    
    (test-case "Multi-Element BST --- Functional Test"
     (let ((a (make-bst <)))
       (define b (add(add (add (add (add a 2 'two) 4 'four) 1 'one) 3 'three) 5 'five))
       (check-equal? (bst-size b) 5 "5 nodes added")
       (define c (delete b 1))
       (check-equal? (bst-size c) 4 "Decrement size")
       (check-equal? (bst-node-left (bst-root c)) '() "1 deleted")
       (define d (delete b 4))
       (check-equal? (bst-size d) 4 "Decrement size")
       (check-equal? (bst-node-right (bst-root d)) '() "4 deleted, and 2 children")
       (define e (add b 6 'six))
       (check-equal? (bst-size e) 6 "Increment size")
       (define f (delete e 5))
       (check-equal? (bst-size f) 5 "Decrement size")
       (check-equal? (bst-node-right (bst-node-right (bst-root f))) '() "5 deleted, and 1 child")
                     
       ;(define b (add a 1 'one))
       ;(define c (add b 2 'two))
       ;(define d (add c 1 'one))
       ;(define e (add d 3 'three))
     ))
))

