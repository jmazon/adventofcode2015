#! /usr/bin/env perl

use re 'eval';

my $fin = shift or die;
open my $in, '<', $fin or die $!;

my %candidates;
@candidates{1..500} = (1) x 500;

while (<DATA>) {
  my ($gift,$count) = /(\w+): (\d+)/;
  # my $re = qr/$gift: $count\b|^(?!.*$gift)/;
  my $op = $gift eq 'cats' || $gift eq 'trees' ? '>' : $gift eq 'pomeranians' || $gift eq 'goldfish' ? '<' : '==';
  my $cond = "\$^N $op $count";
  my $re = qr/$gift: (\d+)\b(?(?{eval $cond})(*ACCEPT)|(*FAIL))|^(?!.*$gift)/;
  seek $in, 0, 0;
  while (<$in>) {
    my ($sue) = /Sue (\d+)/;
    /$re/ or do {
      $candidates{$sue} = 0;
      warn "Eliminating Sue $sue ($re)\n";
    };
  }
}
print "@{[grep $candidates{$_}, keys %candidates]}", $/;

__DATA__
children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1
