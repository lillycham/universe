module           Acronym   (abbreviate) where
import qualified Data.Char as C
import           Control.Monad (unless)

abbreviate :: String -> String
abbreviate x = filter (C.isLetter) $ abbr . (map (C.toUpper . replaceWS)) $ splitCC x

-- Remove camel case
splitCC :: String -> String
splitCC [] = []
splitCC (x:y:xs) | C.isLower x && C.isUpper y = x : ' ' : y : splitCC xs
splitCC (x:xs) = x : splitCC xs

-- Abbreviate words
abbr :: String -> String
abbr = (head <$>). words

-- replace non-alphabetic characters with space
replaceWS x = if (C.isAlpha x) then x else if (x == '\'') then x else ' '
  
