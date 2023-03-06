#lang racket

(define-syntax-rule (forever BODY)
  (begin
    (define (loop)
      BODY
      (loop))
    (loop)))
