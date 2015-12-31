#! /usr/bin/env perl

use Digest::MD5 'md5_hex';

my $key = shift;
my $i = 1;
until ( md5_hex("$key$i") =~ /^000000/ ) { $i++ }
print $i, $/;

