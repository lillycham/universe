#lang racket
(define n 0)
(for ([i (range 1 1000000000)])
    (set! n (+ n 1)))