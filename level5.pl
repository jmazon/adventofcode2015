#! /usr/bin/perl -n

/(..).*\1/
    and
/(.).\1/
    and
$nice++;

END { print $nice, $/ }
    
__END__

(part one)

y/aeiou// >= 3
    and
/(.)\1/
    and
!/ab|cd|pq|xy/
    and
$nice++;

END { print $nice, $/ }
    
