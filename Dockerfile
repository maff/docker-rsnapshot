FROM debian:stable

VOLUME /source
VOLUME /target
VOLUME /config

RUN apt-get update \
    && apt-get install -y --no-install-recommends rsnapshot \
    && rm -rf /var/lib/apt/lists/*

COPY docker-entrypoint.sh /usr/local/bin/

COPY etc/rsnapshot-common.conf /etc
COPY etc/rsnapshot.conf /etc

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["hourly"]