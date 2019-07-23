#!/bin/bash

# Enabling PHP mod rewrite
/usr/sbin/a2enmod rewrite && /etc/init.d/apache2 restart
pm2 status

tail -F /var/log/apache2/* /dev/stdout /dev/stderr
