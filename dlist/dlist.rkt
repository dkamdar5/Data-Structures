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
        (dlist sentinel sentinel 0))))

  ; Here is a size function.  Just because I provide it doesn't mean it's complete!
  (define (size dl)
    (dlist-size dl))

  (define (insert-front xx elt)
    (let ((node (dnode (dlist-sentinal xx) elt (dnode-next (dlist-sentinal xx)))))
      ;node = new dnode. prev = sentinal. data = element. next = next dnode of sentinal.
      (begin
        (set-dnode-prev! (dnode-next node) node);set prev of the next node to itself
        (set-dnode-next! (dlist-sentinel xx) node);set next of the sentinal to itself 
        (inc-dlist-size! dlist))))
  
  (define (insert-back xx elt)
    (let ((node (dnode (dnode-prev (dlist-sentinal xx)) elt (dlist-sentinal xx))))
      ;node = new dnode. prev = prev dnode of sentinal. data = element. next = sentinal.
      (begin
        (set-dnode-prev! (dlist-sentinel xx) node);set prev of sentinal to itselft
        (set-dnode-next! (dnode-prev node) node);set next of the prev node to itself
        (inc-dlist-size! dlist))))
  
  (define insert-ordered null)
  
  (define delete null)
  
  (define dlist-reverse null)
  
  (define dlist-to-cons null)
  
  (define (cons-to-dlist cl)
    make-list)

  ; Test cases here
  (include "test-dlist.rkt")
  )
