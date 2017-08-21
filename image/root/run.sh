#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache openssh-client &&
    mkdir /root/.ssh &&
    chmod 0700 /root/.ssh &&
    apk add --no-cache docker &&
    adduser -D user &&
    mkdir /workspace &&
    chown user:user /workspace &&
    cp -r /root/.c9 /home/user/.c9 &&
    chown user:user /home/user/.c9 &&
    rm -rf /var/cache/apk/*