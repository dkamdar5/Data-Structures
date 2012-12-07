(module traversal racket 
  (provide make-tree add traverse-dfs traverse-bfs
           traverse-preorder traverse-postorder traverse-inorder
           traverse-frontier traversal-tests) 

  ; This macro will create a function that returns "undefined" if it is called.
  ; This should help with debugging.

  (define-syntax-rule (undefine name)
                      (define (name . x) (error (string-append (symbol->string 'name) " undefined.")))) 

  (struct tree (data left right) #:transparent)
  (require data/queue)
  
  (define (make-tree)
    (tree null '() '()))
  
  (define (add t elt)
    (add-aux t elt))
  (define (add-aux t elt)
    (cond [(null? (tree-data t)) (tree elt null null)]
          [(equal? elt (tree-data t)) (tree (tree-data t) (tree-left t) (tree-right t))]
          [(< elt (tree-data t))
           (if (null? (tree-left t)) (tree (tree-data t) (tree elt '() '()) (tree-right t))
               (tree (tree-data t) (add-aux (tree-left t) elt) (tree-right t)))]
          [(> elt (tree-data t))
           (if (null? (tree-right t)) (tree (tree-data t) (tree-left t) (tree elt '() '()))
               (tree (tree-data t) (tree-left t) (add-aux (tree-right t) elt)))]
          (else (tree elt null null))))
  
  (define (traverse-dfs t)
    (dfs-aux t))
  (define (dfs-aux t)
    (cond [(null? t) (stream)]
          (else 
           (stream-append (stream (tree-data t))
                 (dfs-aux (tree-left t)) (dfs-aux (tree-right t))))))
  
  (define (traverse-bfs t)
    (bfs-aux t))
  (define (bfs-aux t)
    (cond [(null? t) (stream)]
          (else
           (define q (make-queue))
           (enqueue! q t)
           (stream (bfs-queue q)))))
  (define (bfs-queue q)
    (unless (queue-empty? q)
      (define node (dequeue! q))
      (stream-append (stream (tree-data node)) (bfs-queue (bfs-enqueue q node)))
      ))
  (define (bfs-enqueue q node)
    (if (not (null? (tree-left node))) (enqueue! q (tree-left node)) (stream))
    (if (not (null? (tree-right node))) (enqueue! q (tree-right node)) (stream))
    )
  
  (define (top q)
    (dequeue! q))
  
  (define (traverse-preorder t)
    (preorder-aux t))
  (define (preorder-aux t)
    (cond [(null? t) (stream)]
          (else 
           (stream-append (stream (tree-data t))
                 (preorder-aux (tree-left t)) (preorder-aux (tree-right t))))))
  
  (define (traverse-inorder t)
            (inorder-aux t))
  (define (inorder-aux t)
    (cond [(null? t) (stream)]
          (else
           (stream-append (inorder-aux (tree-left t)) (stream (tree-data t)) (inorder-aux (tree-right t))
           ))))
  
  (define (traverse-postorder t)
    (postorder-aux t))
  (define (postorder-aux t)
    (cond [(null? t) (stream)]
          (else
           (stream-append (postorder-aux (tree-left t)) (postorder-aux (tree-right t)) (stream (tree-data t))
           ))))
  
  (define (traverse-frontier t)
    (frontier-aux t))
  (define (frontier-aux t)
    (cond [(null? t) (stream)]
          [(null? (and (tree-right t) (tree-left t))) (stream (tree-data t))]
          [(null? (tree-left t)) (stream (tree-data t))]
          [(null? (tree-right t)) (stream (tree-data t))]
          (else 
           (stream-append
                 (frontier-aux (tree-left t)) (frontier-aux (tree-right t))))))
  
  (define (stream-take st num)
    (cond [(stream-empty? st) '()]
          [(equal? num 0) '()]
          (else (cons (stream-first st)
                       (stream-take (stream-rest st) (- num 1))))))

  ; Test cases here
  (include "test-traversal.rkt")
)

