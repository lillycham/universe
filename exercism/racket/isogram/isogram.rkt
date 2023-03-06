#lang racket

(provide isogram?)

;; Helper function to find the index in the Vector of a char.
(define (char->num char)
  (- (char->integer char) (char->integer #\a)))

(define (isogram? s)
  (define letters (make-vector 26))
  ;; remove non alnum chars from the string and downcase it.
  (define str (list->string (filter char-alphabetic? (string->list (string-downcase s)))))
  ;; define an escape cont. to jump back to, for early return.
  (let/ec return
    (for ([c str])
      (vector-set! letters (char->num c) (+ 1 (vector-ref letters (char->num c))))
      (when (> (vector-ref letters (char->num c)) 1) (return #f)))
    (return #t)))
