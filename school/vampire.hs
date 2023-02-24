calcDays x y z = do
    let x' = x*2
        z' = z+1 in if x' < y then calcDays x' y z' else z'

main = do
    putStrLn "UK:"
    putStrLn $ show $ calcDays 1 65600000 1
    putStrLn "World:"
    putStrLn $ show $ calcDays 1 7400000000 1