(module traversal racket 
  (provide make-tree add traverse-dfs traverse-bfs
           traverse-preorder traverse-postorder traverse-inorder
           traverse-frontier traversal-tests) 

  ; This macro will create a function that returns "undefined" if it is called.
  ; This should help with debugging.

  (define-syntax-rule (undefine name)
                      (define (name . x) (error (string-append (symbol->string 'name) " undefined.")))) 

  (struct tree (data left right) #:transparent)
  (struct queue (front back size) #:mutable #:transparent)
  
  (define (make-queue) (queue null null 0))
  
  (define (enqueue q elt)
    (set-queue-size! q (+ (queue-size q) 1))
    (set-queue-back! q (cons elt (queue-back q))))
  
  (define (dequeue q)
     (if (and (null? (queue-front q)) (null? (queue-back q))) null
         (if (null? (queue-front q))
             (begin
               (back-to-front q)
               (set-queue-size! q (- (queue-size q) 1)))
             (begin
               (set-queue-front! q (cdr (queue-front q)))
               (set-queue-size! q (- (queue-size q) 1))))))
   
  (define (top q)
    (back-to-front q)
    (if (null? (queue-front q)) null
              (car (queue-front q))))
  
  (define (back-to-front q)
    (set-queue-front! q (append (queue-front q) (reverse (queue-back q))))
    (set-queue-back! q null)
    )
  
  
  
  
  
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
  
  (undefine traverse-bfs)
  
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
          [(null? (tree-left t)) (stream (tree-data t))]
          [(null? (tree-right t)) (stream (tree-data t))]
          [(null? (and (tree-right t) (tree-left t))) (stream (tree-data t))]
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

