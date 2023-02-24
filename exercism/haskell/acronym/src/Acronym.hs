module           Acronym   (abbreviate) where
import qualified Data.Char as C

abbreviate :: String -> String
abbreviate x = abbr . (C.toUpper <$>) $ filter (C.isAlpha) x

abbr :: String -> String
abbr = (head <$>). words


  
