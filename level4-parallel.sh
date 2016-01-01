#! /usr/bin/bash

regex='^00000'
key=$1
capa=${2:-4}
width=1020 # empirical optimum, YMMV
jobs=0

[[ $# -lt 1 ]] && echo "Usage: $0 <key> [capa]" >&2 && exit 2

for (( i = 0; ; i += width ))
do
    printf "\r$i   " >&2
    args='\<\(echo\ -n\ '$key{$i..$((i+width-1))}'\)'
    args=$(eval echo md5sum $args)

    while (( jobs >= capa )); do
        if (( jobs-- )); wait -n; then
            while (( jobs-- > 0 )); do wait; done
            break 2
        fi
    done

    {
        res=$(eval $args | sed -n "/$regex/ { = ; q }" )
        [[ -n $res ]] && echo $((res + i - 1))
    } &
    (( jobs++ ))
done |

sort -n |
head -1

# Running at capa=4 ends up in 3 minutes instead of 5'25.  I suspect
# most of the time is really forking the "echo -n" processes, but
# there's not much more I can do to mitigate that while still using
# md5sum :-)
