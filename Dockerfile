FROM ubuntu:18.04
MAINTAINER Bas Oudmans <www.oudmans.nl>

ENV DEBIAN_FRONTEND="noninteractive" \
    TERM="xterm" \
    APTLIST="git vim-nox ntp unzip curl zip sudo wget lftp exiftool redis-server redis-tools libimage-exiftool-perl" \
    REFRESHED_AT='2019-07-23'

# PH3 install

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

RUN     curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && apt update && apt install -y nodejs build-essential && \
        npm install pm2 grunt typescript -g

# Start container

COPY    ./start.sh /start.sh
RUN     chmod u+x /start.sh
EXPOSE  80

ENTRYPOINT ["/start.sh"]
