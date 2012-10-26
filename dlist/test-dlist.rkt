;#lang racket/base

(require rackunit)

(define dlist-tests
  (test-suite
    "Tests for the dlist"

    (test-case "Initial dlist Properties"
    (let ((dl (make-dlist)))
      (check-equal? (size dl) 0 "Dlist initially should have size zero.")
      (check-equal? (delete dl) null "")
      (check-equal? (size dl) 0 "")
      ))
    
    (test-case "One Element dlist --- Functional Test"
    (let ((dl (make-dlist)))
      (check-equal? (size dl) 0 "")
      (insert-front dl '10)
      (check-equal? (size dl) 1 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      (insert-back dl '10)
      (check-equal? (size dl) 1 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      (insert-ordered dl '10)
      (check-equal? (size dl) 1 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      ))
    
    (test-case "One Element dlist --- Internal Test"
    (let ((dl (make-dlist)))
      (check-equal? (size dl) 0 "")
      (insert-front dl '10)
      (check-equal? (size dl) 1 "")
      (check-equal? (dnode-data (dnode-next (dlist-sentinal dl))) '10 "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '10 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      (check-equal? (dnode-data (dnode-next (dlist-sentinal dl))) '() "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '() "")
      (insert-back dl '10)
      (check-equal? (size dl) 1 "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '10 "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '10 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      (check-equal? (dnode-data (dnode-next (dlist-sentinal dl))) '() "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '() "")
      (insert-ordered dl '10)
      (check-equal? (size dl) 1 "")
      (check-equal? (dnode-data (dnode-next (dlist-sentinal dl))) '10 "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '10 "")
      (delete dl '10)
      (check-equal? (size dl) 0 "")
      (check-equal? (dnode-data (dnode-next (dlist-sentinal dl))) '() "")
      (check-equal? (dnode-data (dnode-prev (dlist-sentinal dl))) '() "")
      ))
))

