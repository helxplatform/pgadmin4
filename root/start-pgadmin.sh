#!/bin/sh

set -eoux pipefail

random_string () {
	env LC_CTYPE=C tr -dc 'a-zA-Z0-9' < /dev/urandom | fold -w ${1:-32} | head -n 1
}

# export SCRIPT_NAME="$NB_PREFIX"
export PGADMIN_DEFAULT_EMAIL=${PGADMIN_DEFAULT_EMAIL-"${USER}@domain.com"}
export PGADMIN_DEFAULT_PASSWORD=${PGADMIN_DEFAULT_PASSWORD-"$( random_string )"}
export PGADMIN_CONFIG_DATA_DIR=${PGADMIN_CONFIG_DATA_DIR-"/home/${USER}/.helx/pgadmin"}

mkdir -p $PGADMIN_CONFIG_DATA_DIR

# Do any HeLx-specific configurations.
/helx-init.sh

# pgAdmin wants quotes around a string variable name.
export PGADMIN_CONFIG_DATA_DIR="\"$PGADMIN_CONFIG_DATA_DIR\""

cd /pgadmin4
# Start regular entrypoint of pgadmin.
/entrypoint.sh
