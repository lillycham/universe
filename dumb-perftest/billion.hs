import Data.Word

main = go 0 where
    go :: Word32 -> IO ()
    go i | i == 1000000000 = return ()
    go i = go (i + 1)

