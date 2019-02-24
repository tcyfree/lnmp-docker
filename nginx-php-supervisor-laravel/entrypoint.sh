#!/bin/sh
set -e 
/usr/sbin/crond  -L  /var/log/cron/cron.log
supervisord --nodaemon --configuration /etc/supervisor/conf.d/supervisord.conf




