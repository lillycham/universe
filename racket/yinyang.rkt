#lang racket

(let* [{yin
        ((λ (cc) (display #\@) cc) (call/cc (λ (c) c)))}
       
       {yang
        ((λ (cc) (display #\*) cc) (call/cc (λ (c) c)))}] ;; in...
  
  (yin yang))
