# This php tag contains Apache and php7.3
FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt upgrade -y
RUN apt install software-properties-common -y
RUN add-apt-repository ppa:ondrej/php -y
RUN apt update && apt -y install php7.3 ssh

# ENV vars creation
ENV ROOTPWD=pass-root USER1PWD=pass-root1 USER2PWD=pass-root2 USER3PWD=pass-root3

# Creation of users
RUN useradd -m -p $ROOTPWD demo-root && \
useradd -m -p $USER1PWD demo-user1 && \
useradd -m -p $USER2PWD demo-user2 && \
useradd -m -p $USER3PWD demo-user3

# Necessary directories creation
RUN mkdir /mnt/logs/ \
/mnt/logs/apache2 \
/home/demo-root/.ssh \
/home/demo-user1/.ssh \
/home/demo-user2/.ssh \
/home/demo-user3/.ssh

# Keys creation
RUN ssh-keygen -f /home/demo-root/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user1/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user2/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user3/.ssh/id_rsa -P ""

WORKDIR /usr/src/app

COPY . .

# Copy vhost.conf
COPY ./vhosts/example.com.conf /etc/apache2/sites-enabled/000-default.conf

# copy cron files
COPY ./demo.root.cronfile /var/spool/cron/crontabs/root
COPY ./demo.user1.cronfile /var/spool/cron/crontabs/demo-user1
COPY ./demo.user2.cronfile /var/spool/cron/crontabs/demo-user2
COPY ./demo.user3.cronfile /var/spool/cron/crontabs/demo-user3

# Set correct permissions for the droot
RUN chmod -R 777 ./ && chown -R www-data:www-data ./

#RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443

CMD ["apachectl","-D","FOREGROUND"]
