#lang racket
(define (power x y)
  (cond ((eq? y 1) x)
        (else (* x (power x (- y 1))))))

(define (range xy)
  (define (aux x y)
    (cond ((eq? x -1) y)
          (else (aux (- x 1) (cons x y)))))
  (aux (- xy 1) null))

(define (append xx yy)
  (cond ((eq? xx null) yy)
        ((eq? yy null) xx)
        (else (cons (car xx) (append (cdr xx) yy)))))

(define (reverse-bad xx)
  (cond ((eq? (cdr xx) null) xx)
        (else (append (reverse (cdr xx)) (list (car xx))))))

(define (reverse-good xx)
  (define (aux x y)
    (cond ((eq? x null) y)
          (else (aux (cdr x) (cons (car x) y)))))
  (aux xx null))