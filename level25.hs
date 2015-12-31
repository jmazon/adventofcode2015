row = 2981
col = 3075

factor = 252533
base = 33554393

triangular :: Int -> Int -> Int
triangular r c = d * (d-1) `div` 2 + c where d = r + c - 1

power _ 0 _ = 1
power x n b | even n = (power x (n `div` 2) b)^2 `mod` b
            | odd n  = (power x (n-1) b) * x `mod` b

solve1 = 20151125 * power factor (triangular row col - 1) base `mod` base
