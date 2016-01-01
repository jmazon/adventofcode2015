#! /usr/bin/env perl

use 5.014;
use warnings;

sub sigma {
  my $n = shift;
  $_ = qx(factor $n);
  s/.*: //;
  my %p;
  $p{$_}++ for m/\d+/g;
  my $r = 1;
  while (my ($p,$a) = each %p) {
    $r *= ($p ** ($a+1) - 1) / ($p - 1);
  }
  return $r;
}

my $i = 2;
while (1) {
  my $s = sigma $i;
  print "$i: $s\n";
  last if $s >= 3600000;
  $i++;
}

