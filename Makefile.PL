use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'PGObject::Util::Replication::Slot',
    AUTHOR           => q{Chris Travers <chris.travers@adjust.com>},
    VERSION_FROM     => 'lib/PGObject/Util/Replication/Slot.pm',
    ABSTRACT_FROM    => 'lib/PGObject/Util/Replication/Slot.pm',
    LICENSE          => 'bsd',
    PL_FILES         => {},
    MIN_PERL_VERSION => '5.006',
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    BUILD_REQUIRES => {
        'Test::More' => '0',
    },
    PREREQ_PM => {
        'Moo' => 0,
        #'Foo::Bar::Module' => '5.0401',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'PGObject-Util-Replication-Slot-*' },
);
