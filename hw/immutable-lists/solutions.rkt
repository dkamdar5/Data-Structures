#lang racket
(define (delete-all key xx)
  (cond ((eq? xx null) null)
        ((eq? key (car xx)) (delete-all key (cdr xx)))
        (else (cons (car xx) (delete-all key (cdr xx))))))

(define (flatten xx)
  (cond ((eq? xx null) null)
        ((list? (car xx)) (append (flatten (car xx)) (flatten (cdr xx))))
        (else (cons (car xx) (flatten (cdr xx))))))
               
(define (substitute xx from to)
  (cond ((eq? xx null) null)
        ((eq? from (car xx)) (substitute (cons to (cdr xx)) from to))
        (else (cons (car xx) (substitute (cdr xx) from to)))))