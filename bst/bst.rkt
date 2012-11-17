(module bst racket
  (provide make-bst size add find find-val delete size bst-tests)

  (struct bst (root size comp) #:transparent)
  (struct bst-node (key value left right) #:transparent)

  (define (make-bst comp) (bst null 0 comp))

  ; Here is a size function.  Just because I provide it doesn't mean it's complete!
  (define (size bst)
    (bst-size bst))
  
  (define (add tree k v)
    (match tree 
           [(bst root size comp) 
            (let-values ([(nutree added?) (add-aux root comp k v)])
              (if added? (bst nutree (+ size 1) comp)
                (bst nutree size comp)))]))

  (define (add-aux node comp k v)
    (cond [(null? node) (values (bst-node k v '() '()) #t)]
          [(equal? k (bst-node-key node)) 
           (values (bst-node k v (bst-node-left node) (bst-node-right node)) #f)]
          [(comp k (bst-node-key node)) 
           (let-values ([(subnode added?) (add-aux (bst-node-left node) comp k v)])
             (values (rebuild-left node subnode) added?))]
          [else
           (let-values ([(subnode added?) (add-aux (bst-node-right node) comp k v)])
             (values (rebuild-right node subnode) added?))] 
          ))

  ; subnode is the new tree
  (define (rebuild-left node subnode)
      (bst-node (bst-node-key node)
                (bst-node-value node)
                subnode ; rebuild the left subtree
                (bst-node-right node)))

  ; subnode is the new tree
  (define (rebuild-right node subnode)
      (bst-node (bst-node-key node)
                (bst-node-value node)
                (bst-node-left node) 
                subnode)) ; rebuild the right subtree
  
  (define (delete tree k)
    (match tree
      [(bst root size comp)
       (let-values ([(nutree deleted?) (delete-aux root comp k (bst-node-value (bst-root tree)))])
         (if deleted? (bst nutree (- size 1) comp)
             (bst nutree size comp)))]))
  
  (define (delete-aux node comp k v)
    (cond [(null? node) (values (bst-node k v '() '()) #t)]
          [(equal? k (bst-node-key node))
           (cond [(and (null? (bst-node-right node)) (null? (bst-node-left node)))
                  (values (bst-node k v '() '()) #t)]
                 )]
           ;(values (bst-node k v (bst-node-left node) (bst-node-right node)) #f)]
          [(comp k (bst-node-key node))
           (let-values ([(subnode deleted?) (delete-aux (bst-node-left node) comp k v)])
             (values (rebuild-left node subnode) deleted?))]
          [else
           (let-values ([(subnode deleted?) (delete-aux (bst-node-right node) comp k v)])
             (values (rebuild-right node subnode) deleted?))]
      ))
  
  ; subnode is the new tree (left)
  ;(define (rebuild-left node subnode)
    ;  (bst-node (bst-node-key node) (bst-node-value node) subnode (bst-node-right node)))

  ; subnode is the new tree (right)
  ;(define (rebuild-right node subnode)
   ;   (bst-node (bst-node-key node) (bst-node-value node) (bst-node-left node) subnode))


  
  
;(define (find bst k)
;(cond [(null? (bst-root bst)) #f]
;[(eq? (bst-node-key (bst-node)) k) (bst-node)]
;[else {or (find (bst-node-left (bst-node)) k)
;(find (bst-node-right (bst-node)) k)}]))

  (define (find-val bst v)
    (cond [(null? (bst-root bst)) '()]
          [(eq? (bst-node-value (bst-node (bst-root bst)) v)) (bst-node-key (bst-root bst))]
          [else (find-val-aux (bst-node-left (bst-root bst)) (bst-node-right (bst-root bst) v))]))
           
  (define (find-val-aux left right v)
    (cond [(eq? (bst-node-value left v)) left]
           [(eq? (bst-node-value right v)) right]
           [else '()]))
  
  (define (find bst k)
    (cond ((null? (bst-root bst)) '())
        (else (find-aux (bst-root bst) k))))

  (define (find-aux node k)
    (cond [(null? node) '()]
          [(eq? (bst-node-key node) k) (bst-node-value node)]
          [(> k (bst-node-key node)) (find-aux (bst-node-right node) k)]
          [else (find-aux (bst-node-left node) k)]))
  
  ;(define (bst-to-cons tree)
   ; (bst-to-cons-aux (bst-root tree))
    ;)
  
  ;(define (bst-to-cons-aux node)
   ; (cond [(null? node) 'leaf]
    ;      [else(list (bst-node-key node)
     ;                (bst-node-value node)
      ;               (bst-to-cons-aux (bst-node-left node))
       ;              (bst-to-cons-aux (bst-node-right node))
        ;             )]))

  ; Test cases here
  (include "test-bst.rkt")
  (include "draw.rkt")
  )
