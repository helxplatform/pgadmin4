#!/bin/sh

set -eoux pipefail

if [ ! -f "$PGADMIN_CONFIG_DATA_DIR/pgadmin4.db" ]
then
  mkdir -p "$PGADMIN_CONFIG_DATA_DIR"
  cp /helx/pgadmin4.db "$PGADMIN_CONFIG_DATA_DIR/"
fi
