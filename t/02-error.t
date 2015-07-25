#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

use Text::Spintax;

my $invalid = '
test {
';
my $spintax = Text::Spintax->new;
my $node = $spintax->parse($invalid);
ok(not(defined $node),"caught error");
