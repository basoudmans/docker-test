FROM ubuntu:18.04
MAINTAINER Bas Oudmans <bas@ict.oudmans.nl>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm" \
    APTLIST="apache2" \
    REFRESHED_AT='2019-07-21'

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup &&\
    echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
    apt-get -q update && \
    apt-get -qy dist-upgrade && \
    apt-get install -qy $APTLIST && \
    \
    # Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -r /var/www/html && \
    rm -rf /tmp/*

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]
