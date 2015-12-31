#! /usr/bin/perl -p

@_ = /(\w+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)/;
$_ = "@_\n";
