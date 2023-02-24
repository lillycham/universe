module LeapYear (isLeapYear) where

isLeapYear :: Integer -> Bool
isLeapYear y = do
	if y `rem` 400 == 0 then True
	else if y `rem` 100 == 0 && y `rem` 400 /= 0 then False
	else if y `rem` 4 == 0 then True
	else False
