ARG BASE_IMAGE=docker.io/dpage/pgadmin4
ARG BASE_IMAGE_TAG=2023-09-20-2
FROM $BASE_IMAGE:$BASE_IMAGE_TAG

ENV PGADMIN_LISTEN_PORT=8080
ENV PGADMIN_DISABLE_POSTFIX="True"
ENV PGADMIN_CONFIG_SERVER_MODE="False"
ENV PGADMIN_CONFIG_MASTER_PASSWORD_REQUIRED="False"

USER root

COPY root /

# Some files need to be writeable by arbitrary UIDs.
RUN apk add bash shadow && \
    chgrp -R 0 /home /pgadmin4 /venv && \
    chmod -R g=u /home /pgadmin4 /venv && \
    chmod 664 /etc/passwd /etc/group /etc/shadow && \
    chmod 775 /etc  && \
    setcap -r /usr/bin/python3.11

USER pgadmin

ENTRYPOINT /start.sh
