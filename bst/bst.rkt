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
  
  (define (delete aBST key)
    (bst (delete-aux (bst-root aBST) key (bst-comp aBST)) (- (bst-size aBST) 1) (bst-comp aBST))
  )


  (define (delete-aux node k comp)
    (cond ((null? node) '())
          ((equal? k (bst-node-key node)) ; this is the case where we've found what we are looking for
           (let ([has-no-children (and (null? (bst-node-left node)) (null? (bst-node-right node)))]
                 [has-left (not (null? (bst-node-left node)))]
                 [has-right (not (null? (bst-node-right node)))])
             (begin
               (cond ((has-no-children) '())
                     ((has-left) ; has at least one kid
                      (cond ((has-right) null) ;do stuff...) ; has two kids
                            (else (bst-node-left node)))) ; only has one kid
                     ((has-right) ; has at least one kid
                      (cond ((has-left) null);do stuff...) ; has two kids
                            (else (bst-node-right node)))))))) ; has only one kid - case where we found it ends here
          (else
           (cond ((comp k (bst-node-key)) );go left) ; case where we didn't find it
                 (else null));go right))
           )))
  
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

  (define (find-aux node k)
    (cond [(null? node) #f]
        [(eq? (bst-node-key node) k) (bst-node-value node)]
        [else {or (find-aux (bst-node-left (bst-node bst)) k)
                  (find-aux (bst-node-right (bst-node bst)) k)}]))
  
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
