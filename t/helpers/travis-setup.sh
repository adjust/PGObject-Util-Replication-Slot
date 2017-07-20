#!/bin/bash

echo 'ALTER SYSTEM SET max_wal_senders to 5' > psql -U travis
echo 'ALTER SYSTEM SET max_replication_slots to 5' > psql -U travis
service postgresql restart 9.6
