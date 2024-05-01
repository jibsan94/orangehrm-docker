FROM ubuntu:22.04

WORKDIR '/app'

ENV DEBIAN_FRONTEND=noninteractive
RUN  apt-get update -y
RUN  apt install apache2 apache2-data libaio1 libapr1 libaprutil1 libdbd-mysql-perl libdbi-perl \
    libhtml-template-perl libterm-readkey-perl libwrap0 php8.1 php8.1-cli php8.1-common php-json \
     php8.1-mysql php8.1-readline php-curl php-xml php-zip php-intl php-gd php-ldap nano -y

COPY orangehrm-5.6 /var/www/html/orangehrm
COPY orangehrm.conf /etc/apache2/sites-available

RUN chmod -R 777 /var/www/html/orangehrm
RUN a2dissite 000-default.conf
RUN a2ensite orangehrm.conf

CMD ["apachectl", "-D", "FOREGROUND"]
# CMD ["apache2ctl","-k","start"]
