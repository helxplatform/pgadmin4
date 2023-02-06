#!/bin/sh

export SCRIPT_NAME="$NB_PREFIX"
export PGADMIN_CONFIG_DATA_DIR="\"/home/${USER_NAME}/.pgadmin_helx\""
mkdir -p "$PGADMIN_CONFIG_DATA_DIR"
chown -R 5050:5050 "$PGADMIN_CONFIG_DATA_DIR"
chmod 775 "/home/${USER_NAME}"
chown 30000:5050 "/home/${USER_NAME}"

/entrypoint.sh
