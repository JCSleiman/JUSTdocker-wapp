#!/bin/bash
ROOTPWD=pass-root USER1PWD=pass-root1 USER2PWD=pass-root2 USER3PWD=pass-root3

# Creation of users and group assignment.
useradd -m -p $ROOTPWD -s /bin/bash demo-root && \
groupadd -r demogp4 && \
groupadd -r demogp1 && useradd -m -p $USER1PWD -s /bin/bash demo-user1 && usermod -aG demogp1,demogp4 demo-user1 && \
groupadd -r demogp2 && useradd -m -p $USER2PWD -s /bin/bash demo-user2 && usermod -aG demogp2,demogp4 demo-user2 && \
groupadd -r demogp3 && useradd -m -p $USER3PWD -s /bin/bash demo-user3 && usermod -aG demogp3,demogp4 demo-user3
