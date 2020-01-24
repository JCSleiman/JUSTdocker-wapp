#/bin/bash
mkdir /mnt/logs/ \
/mnt/logs/apache2 \
/home/demo-root/.ssh \
/home/demo-user1/.ssh \
/home/demo-user2/.ssh \
/home/demo-user3/.ssh

# Keys creation
ssh-keygen -f /home/demo-root/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user1/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user2/.ssh/id_rsa -P "" && \
ssh-keygen -f /home/demo-user3/.ssh/id_rsa -P ""
