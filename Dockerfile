FROM docker.io/dpage/pgadmin4:2023-01-16-3

USER root

RUN apk update && apk add sqlite

COPY start-pgadmin.sh /start-pgadmin.sh

COPY /root /

USER pgadmin

ENTRYPOINT /start-pgadmin.sh
