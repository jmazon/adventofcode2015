import Data.Array
main = interact $ show . solve . map read . lines
solve xs = minimum $ go 0 0 1 [] [1..n] where
  tw = sum xs `div` 4
  n = length xs
  ps = listArray (1,n) xs
  go w s p rs is | w  > tw = fail "L1 excess"
                 | w == tw = take 1 (go' 0 [] (rs ++ is)) >> return (s,p)
                 | null is = fail "L1 shortage"
                 | w  < tw = go (w+e) (s+1) (p*e) rs is' ++ go w s p (i:rs) is'
    where (i:is') = is
          e = ps!i
  go' w rs is | w  > tw = fail "L2 excess"
              | w == tw = take 1 (go'' 0 (rs ++ is)) >> return ()
              | null is = fail "L2 shortage"
              | w  < tw = go' (w+ps!i) rs is' ++ go' w (i:rs) is'
    where (i:is') = is
  go'' w is | w  > tw = fail "L3 excess"
            | w == tw = return ()
            | null is = fail "L3 shortage"
            | w  < tw = go'' (w+ps!head is) (tail is) ++ go'' w (tail is)
