(require slideshow/pict)
;******************************************************************************************************
;*   This is code to print a bst to the output window in a "2D image" style to make it easy to view   *
;*   Inorder to use this, it must be in the same folder as your "bst.rkt" file and you must include   *
;*   "draw.rkt" from within your BST file, eg: (include "draw.rkt")   like for the test cases         *
;*   There are three methods that can be used when coding the BST structure for testing they are:     *
;*                                                                                                    *
;*   (printTree bsTree) - this prints a tree with out representing null pointers, useful if           *
;*       you have a balanced or small tree, but can get confusing for unbalanced trees                *
;*                                                                                                    *
;*   (printTreeN bsTree) - this prints a tree with nulls included, represented by a "*"               *
;*       this makes the children of a node easier to distinguish, note "*" are also used after        *
;*       nulls to keep the image of the tree balanced, nulls do not actually point to other nulls     *
;*       also the bottom level of nulls is not printed but they are all nulls anyways so who cares?   *
;*                                                                                                    *
;*   (printTreeV bsTree) - this prints nulls like the above method, however it also prints the        *
;*       values of the node, as long as they are string, number, or symbol. For best results          *
;*       use small values eg: apple instead of A long time ago in a galaxy far, far away....          *
;*                                                                                                    *
;*   Check Piazza for better explaination of what the diffrence between the functions are             *
;******************************************************************************************************
(define spacing 14)
(define numbSize 20)
;******************************************************************************************************
;* Change the above value to change the spacing of the numbers in the tree or the size of the numbers *
;******************************************************************************************************
(define (toString data)
  (cond ((string? data) data)
        ((number? data) (number->string data))
        ((symbol? data) (symbol->string data))
        (else "<type>?")))

(define (greater x y)
  (if (> x y) x y))
(define (depth bsTree)
  (if (null? (bst-root bsTree)) 0
      (depth-aux (bst-root bsTree))))
(define (depth-aux node)
  (cond ((and (null? (bst-node-left node)) (null? (bst-node-right node))) 1)
        ((null? (bst-node-left node)) (+ 1 (depth-aux (bst-node-right node))))
        ((null? (bst-node-right node)) (+ 1 (depth-aux (bst-node-left node))))
        (else (+ 1 (greater (depth-aux (bst-node-left node)) (depth-aux (bst-node-right node)))))))

(define (printTree bsTree)
  (if (null? (bst-root bsTree)) (print "bst-root is null")
       (printTree-aux (bst-root bsTree))))
  
(define (printTree-aux node)
  (if (null? node) (blank)
      (vc-append (text (toString (bst-node-key node)) '() numbSize 0) (hc-append spacing (printTree-aux (bst-node-left node)) (printTree-aux (bst-node-right node))))))

(define (printTreeN bsTree)
  (if (null? (bst-root bsTree)) (print "bst-root is null")
      (printTreeN-aux (bst-root bsTree) (depth bsTree))))
(define (printTreeN-aux node level)
  (if (< level 1) (blank)
      (if (null? node) (vc-append (text "*" '() numbSize 0) (hc-append spacing (printTreeN-aux '() (- level 1)) (printTreeN-aux '() (- level 1))))
          (vc-append (text (toString (bst-node-key node)) '() numbSize 0) (hc-append spacing (printTreeN-aux (bst-node-left node) (- level 1)) (printTreeN-aux (bst-node-right node) (- level 1)))))))

(define (printTreeV bsTree)
  (if (null? (bst-root bsTree)) (print "bst-root is null")
      (printTreeV-aux (bst-root bsTree) (depth bsTree))))
(define (printTreeV-aux node level)
  (if (< level 1) (blank)
      (if (null? node) (vc-append (vc-append (text "*" '() numbSize 0) (text "<>" '() numbSize 0)) (hc-append spacing (printTreeV-aux '() (- level 1)) (printTreeV-aux '() (- level 1))))
          (vc-append (vc-append (text (toString (bst-node-key node)) '() numbSize 0) (text (toString (bst-node-value node)) '() numbSize 0)) (hc-append spacing (printTreeV-aux (bst-node-left node) (- level 1)) (printTreeV-aux (bst-node-right node) (- level 1)))))))
;Chuck Kozel