module Main where

fib a b = a:fib b (a+b)

main = print $ sum (filter even (takeWhile (< 4000000) (fib 0 1)))
