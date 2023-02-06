#!/bin/bash

set -eoux pipefail

# Add other init scripts in $HELX_SCRIPTS_DIR with ".sh" as their extension.
# To run in a certain order, name them appropriately.
HELX_SCRIPT_DIR=/helx
INIT_SCRIPTS_TO_RUN=$(ls -1 $HELX_SCRIPT_DIR/*.sh)
for INIT_SCRIPT in $INIT_SCRIPTS_TO_RUN
do
  echo "Running $INIT_SCRIPT"
  $INIT_SCRIPT  
done
