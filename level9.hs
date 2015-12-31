import Data.Ord
import Data.List
main = interact $ solve . map parse . lines
solve ds = show (best,pathLength best)
  where
    cs = nub (map (fst.fst) ds ++ map (snd.fst) ds)
    best = --minimumBy
           maximumBy
           (comparing pathLength) (permutations cs)
    pathLength p = sum $ zipWith dist p (tail p)
    dist a b = case lookup (a,b) ds of
                 Just l -> l
                 Nothing -> case lookup (b,a) ds of Just l -> l
parse l = ((w!!0, w!!2), read (w!!4)) where w = words l
