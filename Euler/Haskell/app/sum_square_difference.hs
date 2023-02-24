main = do
	print $ sum ([1,2..100]) ^ 2 - sum (map (^2) [1,2..100])