#! /bin/bash

IFS=x
while read a b c;
do
    (( x = a * b ))
    (( y = a * c ))
    (( z = b * c ))
    (( m = x ))
    (( y < m )) && (( m = y ))
    (( z < m )) && (( m = z ))
    (( s += m + 2*x + 2*y + 2*z ))
    (( X = a+a+b+b ))
    (( Y = a+a+c+c ))
    (( Z = b+b+c+c ))
    (( M = X ))
    (( Y < M )) && (( M = Y ))
    (( Z < M )) && (( M = Z ))
    (( S += M + a*b*c ))
    echo "$A $B $C -- $X $Y $Z ($M) -- $S"
done
echo $s
echo $S
