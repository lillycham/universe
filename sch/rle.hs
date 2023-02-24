import Data.List (group)

rle x = concatMap (\(c,n) -> [c, ' '] ++ show n) (grp x)
  where grp = map (\x -> (head x, length x)) . group
