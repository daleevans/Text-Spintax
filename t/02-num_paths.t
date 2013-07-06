#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 3;

use Text::Spintax;

my $parser = Text::Spintax->new;
my $node;
$node = $parser->parse("this {is|was} a test");
ok($node->num_paths == 2);

$node = $parser->parse("{a|b|c} {d|e|f}");
ok($node->num_paths == 3*3);

$node = $parser->parse("{a|b|c} {d {e|f}|g|h}");
ok($node->num_paths == 3*(2+1+1));

