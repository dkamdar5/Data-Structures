#lang racket
(define (power x y)
  (cond ((eq? y 1) x)
        (else (* x (power x (- y 1))))))

(define (range x)
  (cond ((eq? x 1) 0)
        (else (cons (range(- x 1)) (- x 1)))))

(define (append xx yy)
  (cond ((eq? xx null) yy)
        ((eq? yy null) xx)
        (else (cons (car xx) (append (cdr xx) yy)))))

(define (reverse xx)
  (cond ((eq? (cdr xx) null) xx)
        (else (cons (reverse(cdr xx)) (car xx)))))