module Temperature (tempToC, tempToF) where

{- Implement the function `tempToC` to convert
`  Fahrenheit to Celsius                    -}

tempToC :: Integer -> Float
tempToC t = ( fromIntegral t - 32) / 1.8


{- Implement the function `tempToF` to convert
`  Celsius to Fahrenheit                    -}

tempToF :: Float -> Integer
tempToF t = ceiling ((t * 1.8) + 32)
