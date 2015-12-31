#! /usr/bin/env perl

use 5.020;

my $program;
while (<>) {
  $program .= "LABEL$.: ";
  chomp;
  if    ( s/^hlf // ) { $program .= "\$$_ = int(\$$_ / 2);"           }
  elsif ( s/^tpl // ) { $program .= "\$$_ *= 3;"                      }
  elsif ( s/^inc // ) { $program .= "\$$_++;"                         }
  elsif ( s/^jmp // ) { $program .= "goto LABEL" . eval("$.$_") . ";" }
  elsif ( s/^jie (.), // ) {
    $program .= "goto LABEL" . eval("$.$_") . " if (\$$1 & 1) == 0;";
  }
  elsif ( s/^jio (.), // ) {
    $program .= "goto LABEL" . eval("$.$_") . " if \$$1 == 1;";
  }
  else { die "Can't parse: $_" }
  $program .= $/;
}
print $program;
# $a++;
eval $program;
say "${@}a = $a; b = $b";
