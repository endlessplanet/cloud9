#!/bin/sh
# This file is part of cloud9.
#
#    cloud9 is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    cloud9 is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with cloud9 .  If not, see <http://www.gnu.org/licenses/>.

NETWORK=$(docker \
    container \
    inspect \
    --format "{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}" \
    $(cat ~/sshd.cid)
) &&
    SHELL_CIDFILE=$(mktemp) &&
    rm ${SHELL_CIDFILE} &&
    docker \
        container \
        run \
        --detach \
        --network ${NETWORK} \
        --cidfile ${SHELL_CIDFILE} \
        --env ID_RSA="$(cat ~/.ssh/id_rsa)" \
        --env USERNAME="Emory Merryman" \
        --env EMAIL="emory.merryman@gmail.com" \
        --env URL="git@github.com:endlessplanet/shell.git" \
        endlessplanet/shell &&
    SHELL_CID=$(cat ${SHELL_CIDFILE}) &&
    rm -f ${SHELL_CIDFILE} &&
    SHELL_VOLUME=$(docker \
        inspect \
        --format "{{ range .Mounts }}{{ if eq .Destination \"/workspace\" }}{{ .Name }}{{ end }}{{ end }}" \
        ${SHELL_CID}
    ) &&
    docker \
        container \
        run \
        --detach \
        --network ${NETWORK} \
        --hostname ${PROJECT_NAME} \
        --name ${PROJECT_NAME} \
        --env PROJECT_NAME \
        --env CONTAINER_ID=${SHELL_CID} \
        --env SSHD_CONTAINER="$(cat ~/sshd.cid)" \
        --volume /var/run/docker.sock:/var/run/docker.sock:ro \
        endlessplanet/cloud9