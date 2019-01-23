#!/bin/sh
set -e 
supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf

/usr/sbin/crond   -f  -L  /var/log/cron/cron.log

#exec redis-server --requirepass develop




