#! /usr/bin/env perl

my %change;
while (<>) {
  chomp;
  if ( / => /p ) { push @{$change{${^POSTMATCH}}}, ${^PREMATCH} }
  elsif ( length ) { last }
}
my @queue = [$_,1];
my $re = join '|', sort { length $b <=> length $a } keys %change;

my %result;
while (@queue) {
    ($_,my $i) = @{pop @queue};
    # print "Expanding $_\n";
    while (/$re/ogp) {
      for my $rep (@{$change{${^MATCH}}}) {
        my $s = $_;
        substr $s, $-[0], $+[0] - $-[0], $rep;
        if ( $s eq 'e' ) {
          print "Final result: $i\n";
          exit;
        }
        next if defined $result{$s};
        $result{$s}++;
        push @queue, [$s,$i+1];
      }
    }
}

# Got correct result by luck: I switched for BFS to DFS without
# changing the pruning, so now in theory the goal could be reached
# early through a non-minimal path.
