main = do
  print $ sum (filter (\x -> x `mod` 3 == 0) [1..10])
