;#lang racket/base

(require rackunit)

(define stack-tests
  (test-suite
    "Tests for the stack"

    (test-case "Initial stack Properties"
    (let  ((s (make-stack)))
      (check-equal? (size s) 0 "stack initially should have size zero.")
      (check-equal? (pop s) null "popping from empty stack returns null.")
      (check-equal? (size s) 0 "popping from empty stack leaves size zero.")))

    (test-case "One Element stack --- Functional Test"
    (let  ((s (make-stack)))
      (check-equal? (size s) 0 "stack initially should have size zero.")
      (push s 10)
      (check-equal? (size s) 1 "Added one element.")
      (check-equal? (top s) 10 "Look at our one element.")
      (pop s)
      (check-equal? (size s) 0 "Size should now be zero.")
      (check-equal? (pop s) null "popping from empty stack returns null.")
      ))

    (test-case "One Element stack --- Internal Test"
    (let  ((s (make-stack)))
      (check-equal? (size s) 0 "stack initially should have size zero.")
      (push s 10)
      (check-equal? (size s) 1 "Added one element.")
      (check-equal? (stack-data s) '(10) "Is the element in the back list?") 
      (check-equal? (top s) 10 "Look at our one element.")
      (check-equal? (stack-data s) '(10) "Is the element in the front list?") 
      (pop s)
      (check-equal? (stack-data s) '() "Is the data empty now?")
      ))

    (test-case "Multi Element stack --- Functional Test"
    (let  ((s (make-stack))
           (elts (list 8 6 7 5 3 0 9))
           )
      (check-equal? (size s) 0 "stack initially should have size zero.")
      (for ((i elts)
            (num (in-range 1 8)))
           (push s i)
           (check-equal? (size s) num "Testing size.")
           (check-equal? (top s) i "Testing top with multiple additions.")
           )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
           (check-equal? (top s) i "Testing top with multiple deletions")
           (pop s)
           (check-equal? (size s) (- num 1) "Testing size.")
           )
      ))

    (test-case "Multi Element stack --- Ebb and Flow Test"
    (let  ((s (make-stack))
           (elts (list 8 6 7 5 3 0 9))
           )
      (check-equal? (size s) 0 "stack initially should have size zero.")
      (for ((i elts)
            (num (in-range 1 8)))
           (push s i)
           (check-equal? (size s) num "Testing size, first flow.")
           (check-equal? (top s) i "Testing top with multiple additions.")
           )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
           (check-equal? (top s) i "Testing top with multiple deletions")
           (pop s)
           (check-equal? (size s) (- num 1) "Testing size, first ebb.")
           )
      (for ((i elts)
            (num (in-range 1 8)))
           (push s i)
           (check-equal? (size s) num "Testing size, second flow.")
           (check-equal? (top s) i "Testing top with multiple additions.")
           )
      (for ((i (reverse elts))
            (num (reverse (stream->list (in-range 1 8)))))
           (check-equal? (top s) i "Testing top with multiple deletions")
           (pop s)
           (check-equal? (size s) (- num 1) "Testing size, second ebb.")
           )
      ))

    (test-case "Multi Element stack --- Internal Test"
    (let  ((s (make-stack))
           (elts (list 5 8 8 2 3 0 0))
           (tmp null)
           )
      (for ((i elts)
            (num (in-range 1 8)))
           (push s i)
           (check-equal? (size s) num "Testing size, second flow.")
           (set! tmp (cons i tmp)) ; "push" element to a list
           (check-equal? (stack-data s) tmp "Stack data is in correct form.")
           )
      ))

    ))

