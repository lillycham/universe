module Main (main) where

import Data.Map

main :: IO ()
main = do
  let x  = create 1 "hi"
  let x' = insert x 2 ":3"
  print x'
  print $ value x' 1
  print $ value x' 5
  print $ searchV x' "n"
  print $ searchV x' ":3"
  print $ getRange x' 1 2
