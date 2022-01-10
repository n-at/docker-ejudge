FROM ubuntu:20.04

MAINTAINER Alexey Nurgaliev <atnurgaliev@gmail.com>

ENV LANG="C.UTF-8" \
    DEBIAN_FRONTEND="noninteractive" \
    \
    APACHE_RUN_USER="www-data" \
    APACHE_RUN_GROUP="www-data" \
    APACHE_LOG_DIR="/var/log/apache2" \
    APACHE_PID_FILE="/var/run/apache2.pid" \
    APACHE_RUN_DIR="/var/run/apache2" \
    APACHE_LOCK_DIR="/var/lock/apache2" \
    APACHE_LOG_DIR="/var/log/apache2" \
    \
    EJUDGE_CGI_DIR="/var/www/ejudge/cgi-bin" \
    EJUDGE_HTDOCS_DIR="/var/www/ejudge/htdocs" \
    EJUDGE_BUILD_DIR="/opt/ejudge-build" \
    EJUDGE_HOME_DIR="/home/ejudge" \
    \
    URL_FREEBASIC="http://downloads.sourceforge.net/fbc/FreeBASIC-1.05.0-linux-x86_64.tar.gz?download" \
    URL_EJUDGE="http://www.ejudge.ru/download/ejudge-3.9.0.tgz"

RUN cd /home &&\
    apt-get update &&\
    apt-get install -y wget mc nano apache2 net-tools locales ncurses-base libncurses-dev libncursesw5 \
                       libncursesw5-dev expat libexpat1 libexpat1-dev \
                       libcurl4-openssl-dev libzip-dev uuid-dev bison flex \
                       gettext gawk zlib1g-dev libelf-dev \
                       g++ fpc openjdk-11-jdk-headless perl python python3 php7.4-cli \
                       &&\
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
    mkdir -m 0777 -p "${EJUDGE_CGI_DIR}" "${EJUDGE_HTDOCS_DIR}" "${EJUDGE_BUILD_DIR}" &&\
    \
    wget -O ejudge.tar.gz --no-check-certificate "${URL_EJUDGE}" &&\
    tar -xvf ejudge.tar.gz -C /opt/ &&\
    rm ejudge.tar.gz &&\
    cd /opt/ejudge &&\
    ./configure --prefix="${EJUDGE_BUILD_DIR}" \
                --enable-contests-home-dir="${EJUDGE_HOME_DIR}" \
                --with-httpd-cgi-bin-dir="${EJUDGE_CGI_DIR}" \
                --with-httpd-htdocs-dir="${EJUDGE_HTDOCS_DIR}" \
                --with-primary-user="ejudge" \
                --with-exec-user="ejudge" \
                --with-compile-user="ejudge" \
                --enable-ajax \
                --enable-charset=utf-8 &&\
    make &&\
    make install &&\
    chown -R ejudge:ejudge "${EJUDGE_BUILD_DIR}" &&\
    "${EJUDGE_BUILD_DIR}/bin/ejudge-suid-setup" &&\
    \
    a2enmod cgi &&\
    rm /etc/apache2/sites-enabled/* &&\
    \
    rm /bin/sh &&\
    ln -s /bin/bash /bin/sh

ADD apache/ejudge.conf /etc/apache2/sites-enabled/ejudge.conf
ADD scripts /opt/scripts

EXPOSE 80

VOLUME ["/home/ejudge", "/var/www/ejudge/htdocs"]

CMD ["/bin/bash", "/opt/scripts/run.sh"]
