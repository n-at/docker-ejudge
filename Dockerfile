FROM ubuntu:16.04

MAINTAINER Alexey Nurgaliev <atnurgaliev@gmail.com>

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND     noninteractive
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR      /var/log/apache2

ENV URL_FREEBASIC       http://downloads.sourceforge.net/fbc/FreeBASIC-1.05.0-linux-x86_64.tar.gz?download
ENV URL_EJUDGE          http://www.ejudge.ru/download/ejudge-3.7.5.tgz

RUN cd /home &&\
    apt-get update &&\
    apt-get install -y wget locales ncurses-base libncurses-dev libncursesw5 \
                       libncursesw5-dev expat libexpat1 libexpat1-dev \
                       zlib1g-dev libelf-dev \
                       g++ gawk apache2 gettext fpc mc openjdk-8-jdk-headless \
                       libcurl4-openssl-dev libzip-dev uuid-dev bison flex \
                       mono-devel mono-runtime mono-vbnc php7.0-cli perl \
                       ruby python python3 gccgo &&\
    \
    locale-gen en_US.UTF-8 ru_RU.UTF-8 &&\
    wget -O freebasic.tar.gz "${URL_FREEBASIC}" &&\
    mkdir /opt/freebasic &&\
    tar -xvf freebasic.tar.gz -C /opt/freebasic --strip-components 1 &&\
    rm freebasic.tar.gz &&\
    cd /opt/freebasic &&\
    ./install.sh -i &&\
    cd /home &&\
    \
    groupadd ejudge &&\
    useradd ejudge -r -s /bin/bash -g ejudge &&\
    mkdir -m 0777 -p /var/www/ejudge/cgi-bin \
                     /var/www/ejudge/htdocs \
                     /opt/ejudge-build &&\
    \
    wget -O ejudge.tar.gz --no-check-certificate "${URL_EJUDGE}" &&\
    tar -xvf ejudge.tar.gz -C /opt/ &&\
    rm ejudge.tar.gz &&\
    cd /opt/ejudge &&\
    ./configure --prefix=/opt/ejudge-build \
                --enable-contests-home-dir=/home/ejudge \
                --with-httpd-cgi-bin-dir=/var/www/ejudge/cgi-bin \
                --with-httpd-htdocs-dir=/var/www/ejudge/htdocs \
                --enable-ajax \
                --enable-charset=utf-8 &&\
    make &&\
    make install &&\
    cd /opt &&\
    chown -R ejudge:ejudge ejudge-build &&\
    \
    a2enmod cgi &&\
    rm /etc/apache2/sites-enabled/*

ADD apache/ejudge.conf /etc/apache2/sites-enabled/ejudge.conf
ADD scripts /opt/scripts

EXPOSE 80

VOLUME /home/ejudge

CMD ["/bin/bash", "/opt/scripts/run.sh"]
