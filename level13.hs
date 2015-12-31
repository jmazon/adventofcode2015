import Data.Ord
import Data.List
main = interact $ show . solve . map parse . lines
parse l = (minMax a b', s' * h') where
  [a,_,s,h,_,_,_,_,_,_,b] = words l
  b' = init b
  s' | s == "gain" = 1
     | s == "lose" = -1
  h' = read h
minMax a b = (min a b, max a b)
solve rs = (best, eval best) where
  (n:ns) = -- "SELF" :
           nub (map (fst . fst) rs ++ map (snd . fst) rs)
  best = (n:) $ maximumBy (comparing (eval . (n:))) (permutations ns) 
  eval t = sum $ concat $ zipWith hp (last t : t) t
  hp a b = map snd $ filter ((== minMax a b) . uncurry minMax . fst) rs
