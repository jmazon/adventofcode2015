step l '(' = l + 1
step l ')' = l - 1
-- solve1 = foldl step 0
solve2 = length . takeWhile (>= 0) . scanl step 0
main = interact $ show . solve2
