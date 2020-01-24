#!/bin/bash
ROOTPWD=pass-root USER1PWD=pass-root1 USER2PWD=pass-root2 USER3PWD=pass-root3

# Creation of users
useradd -m -p $ROOTPWD demo-root && \
useradd -m -p $USER1PWD demo-user1 && \
useradd -m -p $USER2PWD demo-user2 && \
useradd -m -p $USER3PWD demo-user3
