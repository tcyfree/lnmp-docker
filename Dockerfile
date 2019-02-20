#1.ADD-PHP-FPM7.1.14
FROM alpine
#RUN mkdir -p /usr/share/nginx/html/public/
#RUN mkdir -p /usr/local/var/log/php7/
#RUN mkdir -p /usr/local/var/run/
#
#COPY ./php/php-fpm.conf /etc/php7/
#COPY ./php/www.conf /etc/php7/php-fpm.d/
#COPY ./php/index.php /usr/share/nginx/html/public/

#2.ADD-NGINX
RUN apk add nginx

RUN echo 123