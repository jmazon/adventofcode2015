#! /usr/bin/perl -p

my ($op,$a,$b,$c,$d) =
    /(turn on|turn off|toggle) (\d+),(\d+) through (\d+),(\d+)/;
my $opc = $op =~ /on/ ? 1 : $op =~ /off/ ? 2 : 3;
$_ = pack 'C L L L L', $opc, $a, $b, $c, $d;
