import Control.Arrow
import Data.List
import Data.Ord
main = interact $ unlines . map show . race 2503 . map parse . lines
parse l = (n,read s,read t,read r)
  where [n,_,_,s,_,_,t,_,_,_,_,_,_,r,_] = words l
posAt to (n,s,t,r) = (n,s*(t*c+min t m)) where
  (c,m) = to `divMod` (t+r)
race to rs = map (length &&& head) $ group $ sort $
             concatMap (leaders . raceStep) [1..to]
  where
    raceStep i = map (posAt i) rs
    best = snd . maximumBy (comparing snd)
    leaders s = map fst $ filter ((== best s) . snd) s
