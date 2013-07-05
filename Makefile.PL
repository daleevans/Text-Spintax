use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Text::Spintax',
    AUTHOR           => q{Dale Evans <dale.evans@mycanadapayday.com>},
    VERSION_FROM     => 'lib/Text/Spintax.pm',
    ABSTRACT_FROM    => 'lib/Text/Spintax.pm',
    LICENSE          => 'Artistic_2_0',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
        'Parse::Lex' => "2.20",
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Text-Spintax-*' },
);
