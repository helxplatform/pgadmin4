#!/bin/sh

mkdir /home/${USER_NAME}/${USER_NAME}-pgadmin

# Create home and user path variables
#HOME_PATH="/home/${USER_NAME}/${USER_NAME}-pgadmin"
#USER_PATH="/var/lib/pgadmin"

# Install rsync
apk add rsync

# Add a cronjob to the crontab
(crontab -l ; echo "* * * * * rsync -av /var/lib/pgadmin /home/${USER_NAME}/${USER_NAME}-pgadmin >> mylog.log") | crontab -

# Start the cron daemon
crond

## Create a soft link
#function make_soft_link() {
#    echo "Creating symlink"
#    ln -s ${USER_PATH} ${HOME_PATH}
#}

#if [ -d "$USER_PATH" ]; then
#    make_soft_link
#fi

# Start pgadmin4 process
SCRIPT_NAME="$NB_PREFIX" /entrypoint.sh
