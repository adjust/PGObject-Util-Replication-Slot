use Test::More;

use PGObject::Util::Replication::Slot;
use DBI;
use strict;
use warnings;
use Data::Dumper;
#use Carp::Always;

plan skip_all => 'DB_TESTING not set' unless $ENV{DB_TESTING};

my $dbhbase = DBI->connect('dbi:Pg:dbname=postgres'); # no db-specific writes here

$dbhbase->do("SELECT * from version() WHERE version like 'PostgreSQL 9.6.%'");
$dbhbase->rows or plan skip_all => 'Need PostgreSQL 9.6 to test lag monitoring';

plan tests => 4;

$dbhbase->do('SELECT pg_create_physical_replication_slot($$pgobject_test_1$$, true)');
my $slot = PGObject::Util::Replication::Slot->get($dbhbase, 'pgobject_test_1');
ok((defined $slot->restart_lsn), 'Restart lsn is defined;');

$dbhbase->do('CREATE DATABASE pgobject_test_replication_slots');

#writedb to advance log
my $dbh = DBI->connect('dbi:Pg:dbname=pgobject_test_replication_slots'); 
$dbh->do('CREATE TABLE foo(test text)');
my $slot2 = PGObject::Util::Replication::Slot->get($dbhbase, 'pgobject_test_1');


ok($slot2->current_lag_bytes, 'Byte lag > 0');

cmp_ok($slot2->current_lag_bytes, '>=', $slot->current_lag_bytes,
  'Lag has increased'
);

$dbh->disconnect();

$dbhbase->do('DROP DATABASE pgobject_test_replication_slots');

my $slot3 = PGObject::Util::Replication::Slot->get($dbhbase, 'pgobject_test_1');
cmp_ok($slot3->current_lag_bytes, '>=', $slot2->current_lag_bytes,
  'Lag has increased again'
);

PGObject::Util::Replication::Slot->delete($dbhbase, 'pgobject_test_1');

