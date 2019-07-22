FROM ubuntu:18.04
MAINTAINER Bas Oudmans <bas@ict.oudmans.nl>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm" \
    APTLIST="apache2 php7.2 php7.2-curl php7.2-gd php7.2-gmp php7.2-mysql php7.2-pgsql php7.2-xml php7.2-xmlrpc php7.2-mbstring php7.2-zip wget zip" \
    REFRESHED_AT='2019-07-22'

RUN     echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup &&\
        echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache && \
        apt-get -q update && \
        apt-get -qy dist-upgrade && \
        apt-get install -qy $APTLIST && \
        rm -rf /tmp/*

# clean container after install

RUN     apt-get autoclean -y && \
        apt-get autoremove -y && \
        rm -rf /var/lib/{cache,log}/ && \
        rm -rf /var/lib/apt/lists/*.lz4 && \
        rm -rf /tmp/* /var/tmp/* && \
        rm -rf /usr/share/doc/ && \
        rm -rf /usr/share/man/

# Start container

COPY    ./start.sh /start.sh
RUN     chmod u+x /start.sh
EXPOSE  80

ENTRYPOINT ["/start.sh"]
