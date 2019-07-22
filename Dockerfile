FROM ubuntu:18.04
MAINTAINER Bas Oudmans <bas@ict.oudmans.nl>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm" \
    APTLIST="apache2 php7.2 php7.2-curl php7.2-gd php7.2-gmp php7.2-mysql php7.2-pgsql php7.2-xml php7.2-xmlrpc php7.2-mbstring php7.2-zip wget zip" \
    REFRESHED_AT='2019-07-22'

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
    rm -rf /tmp/* && \
    cd /var/www/html/

COPY ./start.sh.sh /start.sh
RUN chmod u+x /start.sh
EXPOSE 80

ENTRYPOINT ["/start.sh"]
