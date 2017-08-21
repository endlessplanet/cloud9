#!/bin/sh

NETWORK=$(docker \
    inspect \
    --format "{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}" \
    $(cat ~/sshd.cid)
) &&
    docker \
        container \
        run \
        --detach \
        --network ${NETWORK} \
        --hostname ${PROJECT_NAME} \
        --name ${PROJECT_NAME} \
        --env PROJECT_NAME \
        --env SSHD_CONTAINER="$(cat ~/sshd.cid)" \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        endlessplanet/cloud9