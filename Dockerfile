FROM ubuntu:22.04

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
    EJUDGE_SPOOL_DIR="/opt/ejudge-spool" \
    \
    URL_FREEBASIC="https://local.doublebyte.ru/static/FreeBASIC-1.10.1-linux-x86_64.tar.gz" \
    URL_EJUDGE="http://www.ejudge.ru/download/ejudge-3.13.0.tgz"

RUN cd /home &&\
    apt-get update &&\
    apt-get install -y wget mc nano apache2 net-tools locales ncurses-base libncurses-dev libncursesw5 \
                       libncursesw5-dev expat libexpat1 libexpat1-dev libmongoc-dev libmysqlclient-dev \
                       libcurl4-openssl-dev libzip-dev uuid-dev bison flex \
                       gettext gawk zlib1g-dev libelf-dev \
                       g++ fpc openjdk-21-jdk-headless perl python2 python3 php8.1-cli \
                       gccgo golang ruby mono-mcs mono-vbnc \
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
    mkdir -m 0777 -p "${EJUDGE_CGI_DIR}" "${EJUDGE_HTDOCS_DIR}" "${EJUDGE_BUILD_DIR}" "${EJUDGE_SPOOL_DIR}" &&\
    \
    wget -O ejudge.tar.gz --no-check-certificate "${URL_EJUDGE}" &&\
    tar -xvf ejudge.tar.gz -C /opt/ &&\
    rm ejudge.tar.gz &&\
    cd /opt/ejudge &&\
    ./configure --prefix="${EJUDGE_BUILD_DIR}" \
                --enable-contests-home-dir="${EJUDGE_HOME_DIR}" \
                --enable-compile-spool-dir="${EJUDGE_SPOOL_DIR}" \
                --with-httpd-cgi-bin-dir="${EJUDGE_CGI_DIR}" \
                --with-httpd-htdocs-dir="${EJUDGE_HTDOCS_DIR}" \
                --with-primary-user="ejudge" \
                --with-exec-user="ejudge" \
                --with-compile-user="ejudge" \
                --enable-ajax \
                --enable-charset=utf-8 &&\
    make RELEASE=1 &&\
    make RELEASE=1 install &&\
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

VOLUME ["/home/ejudge", "/var/www/ejudge/htdocs", "/opt/ejudge-spool"]

CMD ["/bin/bash", "/opt/scripts/run.sh"]
