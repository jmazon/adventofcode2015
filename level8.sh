#! /bin/bash

TMP=level8_$RANDOM
cat > $TMP
trap "rm $TMP" EXIT

L=$( <$TMP tr -d '[:space:]' | wc -c )
Q=$( <$TMP tr -cd \" | wc -c )
E=$( <$TMP grep -oc '\\\\' )
X=$( <$TMP grep -oc '\\x' )
echo $L $Q $E $X
echo $(( Q + E + 3*X ))

# WRONG
