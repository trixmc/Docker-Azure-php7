# Use node v6.9.1
FROM ubuntu:14.04.4

#install Software
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties
RUN apt-get install -y git git-core vim nano mc nginx screen curl unzip wget
RUN apt-get install -y supervisor memcached htop tmux zip

#Install PHP
RUN apt-get install -y language-pack-en-base
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update 
RUN apt-get install -y php7.1 php7.1-cli php7.1-common php7.1-cgi php7.1-curl php7.1-imap 
RUN apt-get install -y php7.1-sqlite3 php7.1-mysql php7.1-fpm php7.1-intl php7.1-gd php7.1-json
RUN apt-get install -y php-memcached php-memcache php-imagick php7.1-xml php7.1-mbstring php7.1-ctype
RUN apt-get install -y php7.1-dev php-pear
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# ------------------------
# SSH Server support
# ------------------------
RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-server \
    && echo "root:Docker!" | chpasswd
COPY init_container.sh /bin/
RUN chmod 755 /bin/init_container.sh

EXPOSE 2222 80 8080

CMD ["/bin/init_container.sh"]