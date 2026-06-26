# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:24.04
LABEL org.opencontainers.image.title=iTop \
      org.opencontainers.image.version=3.3.0-dev \
      org.opencontainers.image.description="iTop-3.3.0-dev & ubuntu-24.04 & apache-2.4 & php-8.3" \
      org.opencontainers.image.authors="purplegrape4@gmail.com"

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        apache2 libapache2-mod-php8.3 \
        php8.3-apcu \
        php8.3-cli \
        php8.3-curl \
        php8.3-gd \
        php8.3-intl \
        php8.3-ldap \
        php8.3-mbstring \
        php8.3-mysql \
        php8.3-opcache \
        php8.3-soap \
        php8.3-xml \
        php8.3-xdebug \
        php8.3-zip \
        graphviz mysql-client curl rsync tzdata && \
    DEBIAN_FRONTEND=noninteractive apt-get autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod headers && \
    a2enmod expires && \
    a2enmod deflate && \
    a2disconf other-vhosts-access-log

#RUN rm -rf /usr/share/perl /usr/lib/x86_64-linux-gnu/perl /usr/lib/x86_64-linux-gnu/perl-base

RUN sed -i '/AllowOverride/s/None/All/g' /etc/apache2/apache2.conf && \
    sed -i '/ErrorLog/d' /etc/apache2/apache2.conf && \
    sed -i '/ports.conf/d' /etc/apache2/apache2.conf && \
    echo "\nListen 8080\nServerTokens Prod\nServerSignature off" >> /etc/apache2/apache2.conf && \
    echo "ErrorLog /proc/self/fd/2" >> /etc/apache2/apache2.conf && \
    echo "CustomLog /proc/self/fd/1 combined" >> /etc/apache2/apache2.conf && \
    sed -i 's/80/8080/g'  /etc/apache2/sites-available/000-default.conf && \
    sed -i '/ErrorLog/d' /etc/apache2/sites-available/000-default.conf && \
    sed -i '/CustomLog/d' /etc/apache2/sites-available/000-default.conf

COPY --from=tianon/gosu --chmod=755 /gosu /usr/bin/
ADD itop /usr/src/itop
ADD --chmod=755 entrypoint.sh /

VOLUME [ "/data" ]
WORKDIR /data
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "apache2ctl", "-D", "FOREGROUND"]
EXPOSE 8080/tcp

HEALTHCHECK --interval=30s CMD curl -sf http://127.0.0.1:8080/images/back.png || exit 1
