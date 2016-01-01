import Data.Maybe
import Control.Monad

weapons = [
    ("Dagger",        8,     4,       0)
  , ("Shortsword",   10,     5,       0)
  , ("Warhammer",    25,     6,       0)
  , ("Longsword",    40,     7,       0)
  , ("Greataxe",     74,     8,       0)
  ]
armors = [
    ("Leather",      13,     0,       1)
  , ("Chainmail",    31,     0,       2)
  , ("Splintmail",   53,     0,       3)
  , ("Bandedmail",   75,     0,       4)
  , ("Platemail",   102,     0,       5)
  ]
rings = [
    ("Damage +1",    25,     1,       0)
  , ("Damage +2",    50,     2,       0)
  , ("Damage +3",   100,     3,       0)
  , ("Defense +1",   20,     0,       1)
  , ("Defense +2",   40,     0,       2)
  , ("Defense +3",   80,     0,       3)
  ]
name (n,_,_,_) = n
cost (_,c,_,_) = c
damage (_,_,d,_) = d
armor (_,_,_,a) = a

equipments = do
  w <- weapons
  as <- upTo 1 armors
  rs <- upTo 2 rings
  return $ w : (as ++ rs)

upTo 0 _ = return []
upTo n [] = return []
upTo n (e:es) = fmap (e:) (upTo (n-1) es) ++ upTo n es

eval es = (sum (map cost es),sum (map damage es),sum (map armor es))

winner = simulate id
loser = simulate not

simulate f selfHP (bossHP,bossDamage,bossArmor) es =
    guard (f victory) >> Just (c,es)
  where
    (c,d,a) = eval es
    sd = max 1 (d - bossArmor)
    st = (bossHP + sd - 1) `div` sd
    bd = max 1 (bossDamage - a)
    bt = (selfHP + bd - 1) `div` bd
    victory = st <= bt

solve1 = minimum $ catMaybes $ map (winner 100 (100,8,2)) equipments
solve2 = maximum $ catMaybes $ map (loser 100 (100,8,2)) equipments
