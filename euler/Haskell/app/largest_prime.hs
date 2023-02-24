import Data.Numbers.Primes

factors :: Int -> [Int]
factors y = [ x | x <- [1..y], y `mod` x == 0]

main = do
  print $ filter isPrime (factors (ceiling $ sqrt 600851475143))