#lang racket

(provide collatz)

(define (collatz num [acc 1])
  (let ([step (collatz-step num)])
    (cond [(<= num 0) (error "bad num")]
          [(= num 1)  0]
          [(= num 1) step]
          [(not (= 1 step)) (collatz step (+ 1 acc))]
          [else acc])))

(define (collatz-step num)
  (if (even? num)
      (/ num 2)
      (+ (* num 3) 1)))
