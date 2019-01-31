#1.ADD-PHP-FPM7.1.14
#FROM bravist/php-fpm-alpine-aliyun-app:1.16
#RUN mkdir -p /usr/share/nginx/html/public/
#RUN mkdir -p /usr/local/var/log/php7/
#RUN mkdir -p /usr/local/var/run/
#
#COPY ./php/php-fpm.conf /etc/php7/
#COPY ./php/www.conf /etc/php7/php-fpm.d/
#COPY ./php/index.php /usr/share/nginx/html/public/
FROM alpine

#2.ADD-NGINX
RUN apk add nginx
#
#COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/
#COPY ./nginx/nginx.conf /etc/nginx/
##COPY ./nginx/cert/ /etc/nginx/cert/
## Expose volumes
#
#VOLUME ["/usr/share/nginx/html", "/usr/local/var/log/php7", "/var/run/"]
#WORKDIR /usr/share/nginx/html
#

#3.ADD-SUPERVISOR
#RUN apk add supervisor \
# && rm -rf /var/cache/apk/*
#
## Define mountable directories.
#VOLUME ["/etc/supervisor/conf.d", "/var/log/supervisor/"]
#COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/
#COPY ./entrypoint.sh /usr/share/nginx/html/
#RUN chmod +x /usr/share/nginx/html/entrypoint.sh

#4.ADD-CRONTABS
COPY ./crontabs/default /var/spool/cron/crontabs/
RUN cat /var/spool/cron/crontabs/default >> /var/spool/cron/crontabs/root
RUN mkdir -p /var/log/cron \
 && touch /var/log/cron/cron.log

VOLUME /var/log/cron

# Define working directory.
WORKDIR /usr/share/nginx/html

#CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["./entrypoint.sh"]