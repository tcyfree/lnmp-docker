#1.Base
#FROM gliderlabs/alpine
FROM 7.1-fpm-alpine3.8


# ensure www-data user exists
#RUN set -x \
#	&& addgroup -g 82  -S www-data \
#	&& adduser -u 82 -D -S -G www-data www-data

RUN apk update \
    apk add nginx

RUN apk add php-fpm
#RUN apk add php7-mysqli \
#    php7-pdo_mysql \
#    php7-mbstring \
#    php7-json \
#    php7-zlib \
#    php7-gd \
#    php7-intl \
#    php7-session \
#    php7-fpm \
#    php7-memcached \
#    php7-redis


RUN mkdir -p /usr/local/var/log/php7/
RUN mkdir -p /usr/local/var/run/
COPY ./php/php-fpm.conf /etc/php7/
COPY ./php/www.conf /etc/php7/php-fpm.d/


#2.ADD-NGINX
RUN apk add nginx
COPY ./nginx/conf.d/default.conf /etc/nginx/conf.d/
COPY ./nginx/nginx.conf /etc/nginx/
COPY ./nginx/cert/ /etc/nginx/cert/
RUN mkdir -p /usr/share/nginx/html/public/
COPY ./php/index.php /usr/share/nginx/html/public/
RUN mkdir -p /run/nginx
RUN touch /run/nginx/nginx.pid
# Expose volumes

VOLUME ["/usr/share/nginx/html", "/usr/local/var/log/php7", "/var/run/"]
WORKDIR /usr/share/nginx/html


#3.ADD-SUPERVISOR
RUN apk add supervisor \
 && rm -rf /var/cache/apk/*

# Define mountable directories.
VOLUME ["/etc/supervisor/conf.d", "/var/log/supervisor/"]
COPY ./supervisor/conf.d/ /etc/supervisor/conf.d/

#4.ADD-CRONTABS
COPY ./crontabs/default /var/spool/cron/crontabs/
RUN cat /var/spool/cron/crontabs/default >> /var/spool/cron/crontabs/root
RUN mkdir -p /var/log/cron \
 && touch /var/log/cron/cron.log

VOLUME /var/log/cron

#5.ADD-REDIS
#RUN apk add redis

#6.ADD-MARIADB不能用
#RUN apk add mariadb=10.3.12-r2
#VOLUME /var/lib/mysql

#设置环境变量，便于管理
#ENV MARIADB_USER root
#ENV MARIADB_PASS 123456
##初始化数据库
#COPY ./mariadb/db_init.sh /etc/
#RUN chmod 775 /etc/db_init.sh
#RUN /etc/db_init.sh

#导出端口
#EXPOSE 3306

#添加启动文件
#ADD ./mariadb/run.sh /root/run.sh
#RUN chmod 775 /root/run.sh
#设置默认启动命令
#CMD ["/root/run.sh"]

# Define working directory.
WORKDIR /usr/share/nginx/html
COPY ./entrypoint.sh /usr/share/nginx/html/
RUN chmod +x /usr/share/nginx/html/entrypoint.sh
#CMD ["supervisord", "--nodaemon", "--configuration", "/etc/supervisor/conf.d/supervisord.conf"]
ENTRYPOINT ["./entrypoint.sh"]
