#lang racket
(define (power x y)
  (cond ((eq? y 1) x)
        (else (* x (power x (- y 1))))))

(define (range x)
  (cond ((eq? x 0) '0)
        (else (cons (range(- x 1)) (cons x null)))))

(define (append xx yy)
  (cond ((eq? xx null) null
        (eq? yy null) null)
        (else (cons (xx yy)))))

(define (reverse xx)
  (cond ((eq? (cdr xx) null) xx)
        (else (cons (reverse(cdr xx)) (car xx)))))