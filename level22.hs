import qualified Data.Set as S
import Control.Monad (join,guard)
import Data.Maybe (isJust)

data St = St { stSpentMana      :: !Int
             , stPlayerHP       :: !Int
             , stPlayerMana     :: !Int
             , stPlayerShield   :: !Int
             , stPlayerRecharge :: !Int
             , stBossHP         :: !Int
             , stBossDamage     :: !Int
             , stBossPoison     :: !Int
             }
          deriving (Show,Eq,Ord)
                    
playerActions st = join $ map ($ st) [
    playerAction  53 4   0  0 0 0 -- magic missile
  , playerAction  73 2 (-2) 0 0 0 -- drain
  , playerAction 113 0   0  6 0 0 -- shield
  , playerAction 173 0   0  0 6 0 -- poison
  , playerAction 229 0   0  0 0 5 -- recharge
  ]

playerAction cost eh ph sh po re st = do
  let mana' = stPlayerMana st - cost
  guard $ mana' >= 0
  return st { stSpentMana = stSpentMana st + cost
            , stPlayerHP = stPlayerHP st - ph
            , stPlayerMana = mana'
            , stPlayerShield = stPlayerShield st + sh
            , stPlayerRecharge = stPlayerRecharge st + re
            , stBossHP = stBossHP st - eh
            , stBossPoison = stBossPoison st + po
            }

start = St { stSpentMana = 0
           , stPlayerHP = 50
           , stPlayerMana = 500
           , stPlayerShield = 0
           , stPlayerRecharge = 0
           , stBossHP = 55
           , stBossDamage = 8
           , stBossPoison = 0 }

effects st = st { stPlayerHP       = stPlayerHP st
                , stPlayerMana     = stPlayerMana st +
                                     if recharge > 0 then 101 else 0
                , stPlayerShield   = max 0 $ stPlayerShield st - 1
                , stPlayerRecharge = max 0 $ recharge - 1
                , stBossHP         = stBossHP st - if poison > 0 then 3 else 0
                , stBossDamage     = stBossDamage st
                , stBossPoison     = max 0 $ poison - 1
                }
  where recharge = stPlayerRecharge st
        poison = stBossPoison st

hit st = st { stPlayerHP = stPlayerHP st -
                           max 1 (stBossDamage st -
                                  if stPlayerShield st > 0 then 7 else 0) }

completeTurn st = case filter (isJust . check) [st,st',st''] of
                    [] -> st'''
                    (v:_) -> v
  where st'   = effects st
        st''  = hit st'
        st''' = effects st''

check st | stPlayerHP st <= 0 = Just False
         | stBossHP st   <= 0 = Just True
         | otherwise          = Nothing

dijkstra next op cl | v == Just True = st
                    | v == Just False = dijkstra next op' cl
                    | otherwise = dijkstra next op'' cl'
  where (st,op') = S.deleteFindMin op
        v = check st
        cl' = S.insert st cl
        op'' = foldr S.insert op' $ filter (`S.notMember` cl') $
               map completeTurn $ next st

solve1 = dijkstra playerActions (S.singleton start) S.empty

playerActionsH st | Just _ <- check st' = return st'
                  | otherwise           = playerActions st' 
  where st' = st { stPlayerHP = stPlayerHP st - 1 }

solve2 = dijkstra playerActionsH (S.singleton start) S.empty
