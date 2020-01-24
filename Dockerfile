# This php tag contains Apache and php7.3
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y \
&& apt install software-properties-common -y \
&& add-apt-repository ppa:ondrej/php -y \
&& apt update && apt -y install php7.3 ssh libapache2-mod-geoip

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

# Copy all the configuration files.
RUN chmod +x scripts/copyfiles.sh && \
./scripts/copyfiles.sh

# Set correct permissions for the droot
RUN chown -R www-data:www-data ./ && a2enmod rewrite

EXPOSE 80
EXPOSE 443

CMD ["apachectl","-D","FOREGROUND"]
