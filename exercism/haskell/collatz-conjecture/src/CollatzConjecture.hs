module CollatzConjecture (collatz) where
import Data.Maybe (fromMaybe, fromJust, isJust)

collatz :: Integer -> Maybe Integer
collatz x | x <= 0         = Nothing
          | x == 1         = Just 0
          | even x         = succ <$> collatz (round $ fromIntegral (x) / 2)
          | otherwise      = succ <$> collatz (round $ fromIntegral (x) * 3 + 1)
