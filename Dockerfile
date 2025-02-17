ARG BASE_IMAGE=docker.io/dpage/pgadmin4
ARG BASE_IMAGE_TAG=9.0
FROM $BASE_IMAGE:$BASE_IMAGE_TAG

ENV PGADMIN_LISTEN_PORT=8080 \
    PGADMIN_DISABLE_POSTFIX="True"

USER root

COPY root /

# Some files need to be writeable by arbitrary UIDs.
RUN apk add bash shadow && \
    chgrp -R 0 /home /pgadmin4 /venv && \
    chmod -R g=u /home /pgadmin4 /venv && \
    chmod 664 /etc/passwd /etc/group /etc/shadow && \
    chmod 775 /etc && \
    setcap -r /usr/bin/python3.12

USER pgadmin

ENTRYPOINT ["/start.sh"]
