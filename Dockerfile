FROM docker.io/dpage/pgadmin4:2023-01-16-3

USER root

COPY start-pgadmin.sh /start-pgadmin.sh
# RUN chmod +x ./start-pgadmin.sh
# RUN chmod -R 777 ./start-pgadmin.sh

COPY /root /

USER pgadmin

ENTRYPOINT /start-pgadmin.sh
