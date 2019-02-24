FROM bravist/php-fpm-alpine-aliyun-app:1.16

RUN apk add nginx

RUN mkdir -p /usr/share/nginx/html/public/
RUN mkdir -p /usr/local/var/log/php7/
RUN mkdir -p /usr/local/var/run/

COPY ./php/php-fpm.conf /etc/php7/
COPY ./php/www.conf /etc/php7/php-fpm.d/
COPY ./php/index.php /usr/share/nginx/html/public/

COPY ./nginx/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/
# Expose volumes

VOLUME ["/usr/share/nginx/html", "/usr/local/var/log/php7", "/var/run/"
WORKDIR /usr/share/nginx/html


#SUPERVISOR
RUN apk add supervisor \
	&& rm -rf /var/cache/apk/*

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d", "/var/log/supervisor/"]

# Define working directory.
WORKDIR /usr/share/nginx/html

#crond
COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/
COPY ./entrypoint.sh /usr/share/nginx/html/
RUN chmod +x /usr/share/nginx/html/entrypoint.sh

COPY ./crontabs/default /var/spool/cron/crontabs/
RUN cat /var/spool/cron/crontabs/default >> /var/spool/cron/crontabs/root
RUN mkdir -p /var/log/cron \
	&& touch /var/log/cron/cron.log
	
VOLUME /var/log/cron


#CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["./entrypoint.sh"]
