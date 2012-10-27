(module traversal racket 
  (provide make-tree add traverse-dfs traverse-bfs
           traverse-preorder traverse-postorder traverse-inorder
           traverse-frontier traversal-tests) 

  ; This macro will create a function that returns "undefined" if it is called.
  ; This should help with debugging.

  (define-syntax-rule (undefine name)
                      (define (name . x) (error (string-append (symbol->string 'name) " undefined.")))) 

  (struct tree (data left right) #:transparent)

  (undefine make-tree)
  (undefine add)
  (undefine traverse-dfs)
  (undefine traverse-bfs)
  (undefine traverse-preorder)
  (undefine traverse-inorder)
  (undefine traverse-postorder)
  (undefine traverse-frontier)

  ; Test cases here
  (include "test-traversal.rkt")
)

