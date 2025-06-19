ARG BASE_IMAGE=docker.io/dpage/pgadmin4
ARG BASE_IMAGE_TAG=9.4
FROM $BASE_IMAGE:$BASE_IMAGE_TAG

ENV PGADMIN_LISTEN_PORT=8080 \
    PGADMIN_DISABLE_POSTFIX="True"

USER root

COPY root /

# Some files need to be writeable by arbitrary UIDs.
RUN setcap -r /usr/bin/python3.12 && \
    apk update && \
    apk upgrade && \
    apk add bash shadow && \
    chgrp -R 0 /home /pgadmin4 /venv && \
    chmod -R g=u /home /pgadmin4 /venv && \
    chmod 664 /etc/passwd /etc/group /etc/shadow && \
    chmod 775 /etc

# Upgrade packages to address known CVEs present in the base 9.4 image.
# These upgrades are intended to be temporary until resolved upstream by pgadmin maintainers,
# and they are highly likely to be inapplicable to future pgadmin4 releases.
RUN /venv/bin/python -m pip install \
    # Upgrades from 75.8.0. Addresses CVE-2025-47273 (path traversal, RCE)
    setuptools==78.1.1 \
    # Upgrades from 0.14.0. Addresses CVE-2025-43859 (request smuggling)
    h11==0.16.0 \
    # Upgrades from 5.29.3. Addresses CVE-2025-4565 (DoS)
    protobuf==5.29.5 \
    # Upgrades from 2.32.3. Addresses CVE-2024-47081 (netrc credential leak)
    requests==2.32.4 \
    # Upgrades from 44.0.0. Addresses CVE-2024-12797 (MITM)
    cryptography==44.0.1 \
    # Upgrades from 3.1.0. Addresses CVE-2025-47278 (session signing using stale keys)
    Flask==3.1.1 \
    # Upgrades from 3.1.5. Addresses CVE-2025-27516 (ACE)
    Jinja2==3.1.6 \
    # Upgrades from 2.4.0. Addresses CVE-2025-50181 and CVE-2025-50182 (open redirects)
    urllib3==2.5.0 \
    # Upgrades from 22.0.0. Addresses CVE-2024-6827 (request smuggling)
    # While I'm hesitant to mess with such a core dependency of pgadmin, the breaking changes from
    # v22 -> v23 are scoped to addressing malicious behavior, and this CVE is applicable to our use-case.
    gunicorn==23.0.0

USER pgadmin

ENTRYPOINT ["/start.sh"]
