#! /usr/bin/sed -Ef

1i\
import Data.Bits\
import Data.Word\
main = print _a

s/([a-z]+)/_\1/g
s/(.*) -> (.*)/\2 = \1 :: Word16/
s/AND/.\&./
s/OR/.|./
s/LSHIFT/`shiftL`/
s/RSHIFT/`shiftR`/
s/NOT/complement/

# part two
# s/_b = .*/_b = 46065/
