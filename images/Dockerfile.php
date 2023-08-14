FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 
ENV TZ=Europe/Madrid
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

RUN apt-get update && apt-get install -y apache2 php libapache2-mod-php php-mysql

COPY ../source/ /var/www/html/

WORKDIR /var/www/html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]