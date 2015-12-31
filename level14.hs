main = interact $ unlines . map (show . posAt 2503 . parse) . lines
parse l = (n,read s,read t,read r)
  where [n,_,_,s,_,_,t,_,_,_,_,_,_,r,_] = words l
posAt to (n,s,t,r) = (n,s*(t*c+min t m)) where
  (c,m) = to `divMod` (t+r)
  
