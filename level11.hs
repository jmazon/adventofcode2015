import Data.List

hasStraight (a:b:c:d) = fromEnum b - fromEnum a == 1 &&
                        fromEnum c - fromEnum a == 2 ||
                        hasStraight (b:c:d)
hasStraight _ = False

noConfuse p = all (`notElem` p) "iol"

hasTwoPairs p = case nub (pairs p) of
                 (_:_:_) -> True
                 _ -> False
  where pairs (a:b:c) | a == b = a : pairs c
        pairs (_:p) = pairs p
        pairs _ = []

valid p = noConfuse p && hasTwoPairs p && hasStraight p

step :: String -> String
step = snd . foldr go (True,[]) where
  go l (True,t) = (l == 'z', l' : t)
    where l' | l == 'z'  = 'a'
             | otherwise = succ l
  go l (False,t) = (False,l:t)

next = head . filter valid . tail . iterate step

-- *Main> next "cqjxjnds"
-- "cqjxxyzz"
-- *Main> next "cqjxxyzz"
-- "cqkaabcc"
