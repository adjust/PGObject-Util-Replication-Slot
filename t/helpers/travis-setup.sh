#!/bin/bash

echo 'ALTER SYSTEM SET max_wal_senders = 5' > psql -U postgres
echo 'ALTER SYSTEM SET max_replication_slots = 5' > psql -U postgres
pg_ctlcluster 9.6 main restart
