import Data.Array

main = format' . (!!100) . iterate (block . step) . block . parse =<< getContents
parse i = listArray ((1,1),(l,l)) (concat ls) where
    ls = lines i
    l = length (head ls)
format' = print . length . filter (== '#') . elems        
format a = unlines $ chunk (elems a) where
    l = fst $ snd $ bounds a
    chunk "" = []
    chunk s = h : chunk t where (h,t) = splitAt l s
step :: Array (Int,Int) Char -> Array (Int,Int) Char
step a = listArray (bounds a) (map f (indices a)) where
    f (i,j) | n == 3 || l && n == 2 = '#' | otherwise = '.' where
      l = (a!(i,j)) == '#'
      n = length $ filter (== '#') $ map (a!) $
          filter (inRange (bounds a)) $
          map (\(a,b) -> (i+a,j+b)) $
          [ (-1,-1), (-1,0), (-1,1), (0,-1), (0,1), (1,-1), (1,0), (1,1) ]
block g = g // [ ((a,b),'#'), ((a,d),'#'), ((c,b),'#'), ((c,d),'#') ] where
    ((a,b),(c,d)) = bounds g
