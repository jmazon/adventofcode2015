#! /usr/bin/env perl

use JSON;
use Scalar::Util 'looks_like_number';
use List::Util 'sum';

sub count {
    my $ref = shift;
    return $ref if looks_like_number $ref;
    return sum map count($_), @$ref if ref $ref eq 'ARRAY';
    if ( ref $ref eq 'HASH' ) {
        return 0 if grep $_ eq 'red', values %$ref;
        return sum map count($_), values %$ref;
    }
    return 0;
}

print count(decode_json(<>)), $/;
