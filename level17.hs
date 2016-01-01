import Data.List
main = interact $ show . solve . map read . words
solve cs = length $
           head $ group $ sort $
           go 150 0 cs (scanr (+) 0 cs) where
    go s n _ (v:vs) | s < 0 = []
                    | s == 0 = return n
                    | v < s = []
                    | v == s = return (n + length vs)
    go s n (c:cs) (v:vs) = go (s-c) (n+1) cs vs ++ go s n cs vs
