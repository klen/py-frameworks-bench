#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.

POSTGRESQL_USER=${POSTGRESQL_USER:-"benchmark"}
POSTGRESQL_PASS=${POSTGRESQL_PASS:-"benchmark"}
POSTGRESQL_DB=${POSTGRESQL_DB:-"benchmark"}
POSTGRESQL_TEMPLATE=${POSTGRESQL_TEMPLATE:-"DEFAULT"}

POSTGRESQL_BIN=/usr/lib/postgresql/9.3/bin/postgres
POSTGRESQL_CONFIG_FILE=/etc/postgresql/9.3/main/postgresql.conf
POSTGRESQL_DATA=/var/lib/postgresql/9.3/main

POSTGRESQL_SINGLE="sudo -u postgres $POSTGRESQL_BIN --single --config-file=$POSTGRESQL_CONFIG_FILE"

if [ ! -d $POSTGRESQL_DATA ]; then
    echo "Init DATABASE"
    mkdir -p $POSTGRESQL_DATA
    chown -R postgres:postgres $POSTGRESQL_DATA
    sudo -u postgres /usr/lib/postgresql/9.3/bin/initdb -D $POSTGRESQL_DATA -E 'UTF-8'
fi

echo "Create USER $POSTGRESQL_USER"
echo "CREATE USER $POSTGRESQL_USER WITH SUPERUSER;" | $POSTGRESQL_SINGLE
echo "ALTER USER $POSTGRESQL_USER WITH PASSWORD '$POSTGRESQL_PASS';" | $POSTGRESQL_SINGLE

echo "Create DATABASE $POSTGRESQL_DB"
echo "CREATE DATABASE $POSTGRESQL_DB OWNER $POSTGRESQL_USER TEMPLATE $POSTGRESQL_TEMPLATE;" | $POSTGRESQL_SINGLE

exec sudo -u postgres $POSTGRESQL_BIN --config-file=$POSTGRESQL_CONFIG_FILE
