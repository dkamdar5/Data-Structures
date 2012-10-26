(module dlist racket
  (provide make-dlist size insert-front insert-back insert-ordered
           delete dlist-reverse dlist-to-cons cons-to-dlist
           dlist-tests)

  (struct dlist (sentinel size) #:mutable #:transparent)
  (struct dnode (prev data next) #:mutable #:transparent)

  (define (make-dlist)
    (let ((sentinel (dnode null 'sentinel null)))
      (begin
        (set-dnode-prev! sentinel sentinel)
        (set-dnode-next! sentinel sentinel)
        (dlist sentinel 0))))

  ; Here is a size function.  Just because I provide it doesn't mean it's complete!
  (define (size dl)
    (dlist-size dl))
  
  (define (inc-dlist-size! dl)
    (set-dlist-size! dl (+ (dlist-size dl) 1)))

  (define (insert-front dl elt)
    (let ((node (dnode (dlist-sentinel dl) elt (dnode-next (dlist-sentinel dl)))))
      ;node = new dnode. prev = sentinal. data = element. next = next dnode of sentinal.
      (begin
        (set-dnode-prev! (dnode-next node) node);set prev of the next node to itself
        (set-dnode-next! (dlist-sentinel dl) node);set next of the sentinal to itself 
        (inc-dlist-size! dl))))
  
  (define (insert-back dl elt)
    (let ((node (dnode (dnode-prev (dlist-sentinel dl)) elt (dlist-sentinel dl))))
      ;node = new dnode. prev = prev dnode of sentinal. data = element. next = sentinal.
      (begin
        (set-dnode-prev! (dlist-sentinel dl) node);set prev of sentinal to itselft
        (set-dnode-next! (dnode-prev node) node);set next of the prev node to itself
        (inc-dlist-size! dl))))
  
  (define (find-greater dn elt)
    (cond ((null? dn) null)
          ((< elt (dnode-data dn)) dn)
          (else (find-greater (dnode-next dn) elt))))
  
  (define (insert-ordered dl elt)
    (if ((eq? (size dl)) 0) (insert-front dl elt)
     (find-greater (dnode-next (dlist-sentinel dl)) elt)))
  
  (define (delete dl elt)
    (if (null? (find-greater dl elt)) null
        (if ((eq? (dnode-data (dnode-prev (find-greater dl elt)))))
            ()))
    )
  
  (define (dlist-reverse dl)
    null
    )
  
  (define (dlist-to-cons dl)
    (define (aux x y)
      (cond ((equal? (dlist-size x) 0) y)
            (else
             (define y (cons (dnode-data (dnode-prev (dlist-sentinel x))) y))
             ;(delete x (car y))
             (aux x y))))
    (aux dl '()))
  
  (define (cons-to-dlist cl)
    (define dl (make-dlist))
    (define (aux x y)
      (cond ((null? x) y)
            (else
               (insert-back dl (car x))
               (aux (cdr x) dl))))
    (aux cl dl))

  ; Test cases here
  (include "test-dlist.rkt")
  )
