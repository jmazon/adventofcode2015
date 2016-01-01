#! /usr/bin/bash

regex='^00000'
key=$1
width=1020 # empirical optimum, YMMV

echo -n ${key}0 | md5sum | grep -q "$regex" && echo 0 && exit

coproc MD5 \
for (( i = 1; ; i += width ))
do
    printf "\r$i   " >&2
    args='\<\(echo\ -n\ '$key{$i..$((i+width-1))}'\)'
    args=$(eval echo $args)
    eval md5sum $args
done

sed -n "/$regex/ { = ; q }" <& $MD5
kill $MD5_PID
wait $MD5_PID 2> /dev/null

# Solves my part one in about 5', so I estimate it'd solve my part two
# in 2:30.

# Parallelizing would be interesting, but would make the general
# structure much more complex; right now I'm simply checking hashes
# one after the other and writing the line number of the first match.
