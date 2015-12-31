#! /usr/bin/perl -n

chomp;
my $q = y/"//;
my $e = y/\\//;

my $c = length $_;
$_ = eval $_;
my $m = length $_;
print "$c $m\n";

our $t += $c - $m;
our $T += 2 + $q + $e;

END { print $t, $/, $T, $/ }
