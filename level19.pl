#! /usr/bin/env perl

my %change;
my %results;
while (<>) {
  chomp;
  if ( / => /p ) { push @{$change{${^PREMATCH}}}, ${^POSTMATCH} }
  elsif ( length ) {
    my $re = join '|', keys %change;
    while (/$re/ogp) {
      for my $rep (@{$change{${^MATCH}}}) {
        my $s = $_;
        substr $s, $-[0], $+[0] - $-[0], $rep;
        $results{$s}++;
      }
    }
    print scalar keys %results, $/;
  }
}
