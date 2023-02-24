import Data.Numbers.Primes
x = filter isPrime [1,2..2000000]
main = print . sum $ x