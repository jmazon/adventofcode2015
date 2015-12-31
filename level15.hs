import Control.Arrow
import Data.List
main = interact $ show . solve . map parse . lines
parse l = (n,map read ns) where (n:ns) = words l
solve is = maximum $ map fst $ filter ((== 500) . snd) $
           (map (score &&& cals) (perms 100 is)) where
  perms 0 _ = return []
  perms c (i:is) = do
    q <- [0..c]
    ps <- perms (c-q) is
    return $ (q,i) : ps
  perms _ _ = []
  score r = product $ map (max 0 . sum) $ transpose $
            map ((\(q,ps) -> map (*q) (init ps)) . second snd) r
  cals r = sum $ map ((\(q,ps) -> q * last ps) . second snd) r
