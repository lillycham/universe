#lang racket/base

(require racket/contract
         racket/function)

(define/contract (letter-counts/thread xs)
  ((listof string?) . -> . (listof (hash/c char? integer?)))
  (define chans (for/list ([x xs])      ; Channels of results
                  (make-channel)))
  (for ([str xs]
        [c chans])
    (thread (thunk (channel-put c (letter-count str)))))
  (for/list ([c chans])
    (channel-get c)))

(define/contract (letter-counts xs)
  ((listof string?) . -> . (listof (hash/c char? integer?)))
  (map letter-count xs))

(define/contract (letter-count string)
  (string? . -> . (hash/c char? integer?))
  (define ft (make-hash))               ; Frequency table
  (for ([c (string->list string)])
    (hash-increment ft c))
  ft)                                   ; ret

;;
(define/contract (hash-increment tab key)
  (hash? any/c . -> . void?)
  (hash-set! tab key (+ 1 (hash-ref tab key 0))))
