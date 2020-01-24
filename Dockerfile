# This ubuntu image contains Apache and php7.3
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

# Installing necessary dependencies like ssh, gcc and make to compile sqlite3
RUN apt update && apt upgrade -y \
&& apt install software-properties-common -y \
&& add-apt-repository ppa:ondrej/php -y \
&& apt update && apt -y install php7.3 ssh libapache2-mod-geoip gcc make

# Installing sqlite 3.31
RUN wget https://www.sqlite.org/2020/sqlite-autoconf-3310000.tar.gz && \
tar xvfz sqlite-autoconf-3310000.tar.gz && \
cd sqlite-autoconf-3310000 && \
./configure && \
make && \
make install && \
mv sqlite3 /usr/bin/sqlite3

WORKDIR /usr/src/app

COPY . .

### SCRIPTS EXECUTION ###

# ENV vars and Users creation of users.
RUN chmod +x scripts/createusers.sh && \
./scripts/createusers.sh

# Necessary folders and keys creation.
RUN chmod +x scripts/folder-keys-creation.sh && \
./scripts/folder-keys-creation.sh

#COPY keys/demo-root/. /home/demo-root/.ssh/

#Copy all the configuration files.
RUN chmod +x scripts/copyfiles.sh && \
./scripts/copyfiles.sh

# Set correct permissions for the droot
RUN chown www-data:www-data -R ./ && find . -type d -exec chmod 755 {} \; && find . -type f -exec chmod 644 {} \; && a2enmod rewrite

EXPOSE 80
EXPOSE 443

CMD ["apachectl","-D","FOREGROUND"]
