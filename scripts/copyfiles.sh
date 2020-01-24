#/bin/bash
# Copy vhost.conf
cp ./vhosts/example.com.conf /etc/apache2/sites-enabled/000-default.conf
cp vhosts/example.com.redirects /etc/apache2/sites-enabled/example.com.redirects

# copy cron files
cp ./demo.root.cronfile /var/spool/cron/crontabs/root
cp ./demo.user1.cronfile /var/spool/cron/crontabs/demo-user1
cp ./demo.user2.cronfile /var/spool/cron/crontabs/demo-user2
cp ./demo.user3.cronfile /var/spool/cron/crontabs/demo-user3
