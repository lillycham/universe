module Main where
import Data.Char (toLower)
import Data.List ((\\))
import System.Environment (getArgs)

isPangram :: String -> Bool
isPangram = null . ( ['a' .. 'z'] \\ ) . map toLower

main :: IO ()
main = do
	args <- getArgs
	let s = concat $ args
	print $ isPangram s