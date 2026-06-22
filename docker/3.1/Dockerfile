# syntax=docker/dockerfile:1
FROM docker.io/library/ubuntu:22.04
RUN DEBIAN_FRONTEND=noninteractive apt-get update ;\
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apache2 libapache2-mod-php8.1 php8.1-opcache php8.1-curl php8.1-gd php8.1-mbstring php8.1-mysql php8.1-ldap php8.1-xml php8.1-soap php8.1-zip php8.1-apcu graphviz mysql-client wget tzdata unzip ;\
    DEBIAN_FRONTEND=noninteractive apt-get autoclean

RUN wget --no-check-certificate https://sourceforge.net/projects/itop/files/itop/3.1.3/iTop-3.1.3-16204.zip/download -O /opt/iTop-3.1.zip

RUN echo "ServerTokens Prod\nServerSignature off" >> /etc/apache2/apache2.conf
RUN sed -i '/AllowOverride/s/None/All/g' /etc/apache2/apache2.conf
RUN sed -i 's#ErrorLog.*#ErrorLog /proc/self/fd/2#g' /etc/apache2/apache2.conf /etc/apache2/sites-available/*.conf
RUN sed -i 's#CustomLog.*#CustomLog /proc/self/fd/1 combined#g' /etc/apache2/sites-available/*.conf
RUN rm -rf /var/lib/apt/lists/* /etc/apache2/conf-available/other-vhosts-access-log.conf

WORKDIR /data
ADD --chmod=755 entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
