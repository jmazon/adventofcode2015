#! /usr/bin/env perl

my ($x,$y,$X,$Y) = (0,0,0,0);
$_{$x,$y}++;
$_ = do { local $/; <> };
while (length) {
    my $d = substr($_, 0, 1, '');
    if ( $d eq '>' ) { $x++ }
    elsif ( $d eq '<' ) { $x-- }
    elsif ( $d eq '^' ) { $y-- }
    elsif ( $d eq 'v' ) { $y++ }
    else { next }
    $_{$x,$y}++;
    ($X,$Y,$x,$y) = ($x,$y,$X,$Y);
}
print scalar keys %_, $/;

__END__

(part one)

my ($x,$y) = (0,0);
$_{$x,$y}++;
$_ = do { local $/; <> };
while (length) {
    my $d = substr($_, 0, 1, '');
    if ( $d eq '>' ) { $x++ }
    elsif ( $d eq '<' ) { $x-- }
    elsif ( $d eq '^' ) { $y-- }
    elsif ( $d eq 'v' ) { $y++ }
    else { next }
    $_{$x,$y}++;
}
print scalar keys %_, $/;
