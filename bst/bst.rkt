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
  
  ;(define (add bst key value)
    ;(bst (aux (bst-root bst) key value bst) (+ (size bst) 1) (bst-comp bst)))
  
  ;(define (aux node key value bst)
    ;(cond ((null? node) (bst-node key value null null))
          ;((bst-comp bst) key (bst-node-key node))
          ;(bst-node (bst-node-key node) (bst-node-value node) (aux (bst-node-left node) key value) (bst-node-right node))
    ;(else (bst-node (bst-node-key node) (bst-node-value node) (bst-node-left node) (aux (bst-node-right node) key value)))))
  
    
  (define delete null)
  
;(define (find bst k)
;(cond [(null? (bst-root bst)) #f]
;[(eq? (bst-node-key (bst-node)) k) (bst-node)]
;[else {or (find (bst-node-left (bst-node)) k)
;(find (bst-node-right (bst-node)) k)}]))

(define (find-val bst k)
(cond [(null? (bst-root bst)) #f]
[(eq? (bst-node-key (bst-node) k)) (bst-node-value)]
[else {or (find-val (bst-node-left (bst-node)) k)
(find-val (bst-node-right (bst-node)) k)}]))
  
  (define (find bst k)
  (cond [(null? (bst-root bst)) #f] ;()s error
        [else (find-aux (bst-root bst) k)]))

(define (find-aux node k); (bst-node bst) should just be a variable node
  (cond [(null? node) #f] ;used node variable
        [(eq? (bst-node-key node) k) (bst-node-value node)] ;if the correct node is found then you are to return its value Not the node itself
        ;I did not change this last part because this searching method is incorrect
        [else {or (find-aux (bst-node-left (bst-node bst)) k)
                  (find-aux (bst-node-right (bst-node bst)) k)}]))
  
  (define (bst-to-cons tree)
    (bst-to-cons-aux (bst-root tree))
    )
  
  (define (bst-to-cons-aux node)
    (cond [(null? node) 'leaf]
          [else(list (bst-node-key node)
                     (bst-node-value node)
                     (bst-to-cons-aux (bst-node-left node))
                     (bst-to-cons-aux (bst-node-right node))
                     )]))

  ; Test cases here
  (include "test-bst.rkt")
  (include "draw.rkt")
  )
