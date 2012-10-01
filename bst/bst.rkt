(module bst racket
  (provide make-bst size add find find-val delete size bst-tests)

  (struct bst (root size comp) #:transparent)
  (struct bst-node (key value left right) #:transparent)

  (define (make-bst comp) (bst null 0 comp))

  ; Here is a size function.  Just because I provide it doesn't mean it's complete!
  (define (size bst)
    0)

  (define add null)
  (define delete null)
  (define find null)
  (define find-val null)

  ; Test cases here
  (include "test-bst.rkt")
  )
