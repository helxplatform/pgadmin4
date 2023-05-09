FROM docker.io/dpage/pgadmin4:2023-01-16-3

USER root

COPY start-pgadmin.sh /start-pgadmin.sh

COPY /root /

# config_distro.py needs to be writeable by arbitrary UIDs.  Probably better
# ways of doing this.
RUN chmod 666 /pgadmin4/config_distro.py

USER pgadmin

ENTRYPOINT /start-pgadmin.sh
