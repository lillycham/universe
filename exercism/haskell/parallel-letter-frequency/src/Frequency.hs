module Frequency (frequency) where

import Data.Map  (Map)
import Data.Text (Text)
import Control.Parallel

frequency :: Int -> [Text] -> Map Char Int
frequency nWorkers texts = 
	let chunks = splitInto nWorkers texts
			freqs  = map (frequency' . concat) chunks
	in  foldl1 (parMapReduceWithKey rseq rseq (+)) freqs