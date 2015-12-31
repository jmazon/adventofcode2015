#! /bin/bash

TMP=level1_$RANDOM
cat >$TMP
trap "rm $TMP" EXIT

UP=$( < $TMP tr -d \) | wc -c )
DOWN=$( < $TMP tr -d \( | wc -c )
echo $((UP - DOWN))
