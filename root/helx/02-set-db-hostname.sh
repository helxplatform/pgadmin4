#!/bin/sh

set -eoux pipefail

if [ ! -z "$HELX_DB_HOSTNAME" ]
then
  sqlite3 "$PGADMIN_CONFIG_DATA_DIR/pgadmin4.db" "UPDATE server SET host = \"$HELX_DB_HOSTNAME\" WHERE host = \"mimic-postgresql\""
fi
