#lang racket

(provide acronym)

(define (acronym string)
  (string-upcase (abbr (specials->ws string))))

(define (abbr string)
  (list->string (map car (map string->list (string-split string)))))

(define (special->ws char)
  (if [or (char=? #\_ char) (char=? #\- char)]
      #\space
      char))

(define (specials->ws string)
  (list->string (map special->ws (string->list string))))
