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
    0)

  (define insert-front null) 
  (define insert-back null)
  (define insert-ordered null)
  (define delete null)
  (define dlist-reverse null)
  (define dlist-to-cons null)
  (define cons-to-dlist null)

  ; Test cases here
  (include "test-dlist.rkt")
  )
