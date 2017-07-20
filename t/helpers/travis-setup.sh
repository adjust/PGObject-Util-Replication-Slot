#!/bin/bash

psql -c 'ALTER SYSTEM SET max_wal_senders to 5'
psql -c 'ALTER SYSTEM SET max_replication_slots to 5'
sudo service postgresql stop
sudo service postgresql start 9.6
