#!/bin/sh

ssh-keygen -f /root/.ssh/id_rsa -P "" &&
    SSHD_PORT=$(cat /root/.ssh/id_rsa.pub | docker \
        container \
        exec \
        --interactive \
        ${SSHD_CONTAINER} \
        sh /opt/docker/reserve-ports.sh) &&
    docker \
        container \
        exec \
        --interactive \
        ${SSHD_CONTAINER} \
        ssh-keyscan sshd > /root/.ssh/known_hosts &&
    chmod 0755 /root/.ssh/known_hosts &&
    (nohup ssh -fN -R 127.0.0.1:${SSHD_PORT}:127.0.0.1:8181 sshd </dev/null >/tmp/sshd1.log 2>&1 &) &&
    (nohup ssh -fN -L 0.0.0.0:80:0.0.0.0:${SSHD_PORT} sshd </dev/null >/tmp/sshd2.log 2>&1 &) &&
    su user /opt/docker/listen.sh