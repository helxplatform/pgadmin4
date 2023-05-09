#!/bin/sh

set -eoux pipefail

export SCRIPT_NAME="$NB_PREFIX"
export PGADMIN_CONFIG_DATA_DIR="/home/${USER_NAME}/.helx/pgadmin"

mkdir -p $PGADMIN_CONFIG_DATA_DIR

# Do any HeLx-specific configurations.
/helx-init.sh

# pgAdmin wants quotes around a string variable name.
export PGADMIN_CONFIG_DATA_DIR="\"$PGADMIN_CONFIG_DATA_DIR\""

# Start regular entrypoint of pgadmin.
/entrypoint.sh
