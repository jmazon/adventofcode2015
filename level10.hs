import Control.Arrow
import Data.List
step :: String -> String
step = concatMap (uncurry (++) <<< show . length &&& (:"") . head) . group

-- length $ (iterate step "1113122113") !! 40
