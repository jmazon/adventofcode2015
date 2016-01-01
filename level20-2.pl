my $i = 1;
my @wheel;
while (1) {
  $_ += 11 * $i for @wheel[map $_ * $i, 1..50];
  printf "\r%8d: %8d", $i, $wheel[$i];
  last if $wheel[$i] >= 36000000;
  $i++;
}
print "\n";
