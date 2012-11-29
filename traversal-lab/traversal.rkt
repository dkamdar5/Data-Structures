(module traversal racket 
  (provide make-tree add traverse-dfs traverse-bfs
           traverse-preorder traverse-postorder traverse-inorder
           traverse-frontier traversal-tests) 

  ; This macro will create a function that returns "undefined" if it is called.
  ; This should help with debugging.

  (define-syntax-rule (undefine name)
                      (define (name . x) (error (string-append (symbol->string 'name) " undefined.")))) 

  (struct tree (data left right) #:transparent)

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
  
  (undefine traverse-dfs)
  (undefine traverse-bfs)
  (define (traverse-preorder t)
    (let ([empty-stream (stream)])
      (begin
        (preorder-aux t (empty-stream)))))
  (define (preorder-aux t next)
    (if (null? (tree-data t)) next
        (stream-append (null) null)
        ))
  
  (undefine traverse-inorder)
  
  (define (traverse-postorder t)
    (let ([empty-stream (stream)])
      (begin
        (postorder-aux t empty-stream))))
  (define (postorder-aux t next)
    (if (null? t) next
        (stream-append (postorder-aux (tree-left t)
            (postorder-aux (tree-right t) next)) (stream-cons (tree-data t) next))))
  
  (undefine traverse-frontier)
  
  (define (stream-take st num)
    (cond [(stream-empty? st) '()]
          [(equal? num 0) '()]
          (else (cons (stream-first st)
                       (stream-take (stream-rest st) (- num 1))))))

  ; Test cases here
  (include "test-traversal.rkt")
)

