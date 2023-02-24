module DNA (nucleotideCounts, Nucleotide(..)) where

import Data.Map (Map, fromList, adjust)

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

asNucleotide :: Char -> Either String Nucleotide
asNucleotide xcx = case xcx of
                    'G' -> Right G
                    'C' -> Right C
                    'T' -> Right T
                    'A' -> Right A
                    xcx'-> Left "error"

initialMap = fromList [(G, 0), (C, 0), (T, 0), (A,0)]

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = fmap (foldr f initialMap) counts
                      where f c accu = adjust (+1) c accu
                            counts = traverse asNucleotide xs
