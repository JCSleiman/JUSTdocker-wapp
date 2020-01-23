# This php tag contains Apache and php7.3
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update && apt -y install php7.3

# Necessary directories creation

RUN mkdir /mnt/logs/ && \
/mnt/logs/apache2 && \
/home/demo-root && \
/home/demo-user1 && \
/home/demo-user2 && \
/home/demo-user3

# Creation of the users
useradd -m -p $ROOTPWD demo-root
useradd -m -p $USER1PWD demo-user1
useradd -m -p $USER2PWD demo-user2
useradd -m -p $USER3PWD demo-user3

WORKDIR /usr/src/app

COPY . .
# Copy vhost.conf
COPY ./vhosts/example.com.conf /etc/apache2/sites-enabled/

# copy cron files
COPY ./demo.root.cronfile /var/spool/cron/crontabs/root
COPY ./demo.user1.cronfile /var/spool/cron/crontabs/demo-user1
COPY ./demo.user2.cronfile /var/spool/cron/crontabs/demo-user2
COPY ./demo.user3.cronfile /var/spool/cron/crontabs/demo-user3

# Passwords for the created users
ENV ROOTPWD=demo-root

#RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443

CMD ["apachectl","-D","FOREGROUND"]
