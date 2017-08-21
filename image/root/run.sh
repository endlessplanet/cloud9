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

apk update &&
    apk upgrade &&
    apk add --no-cache openssh-client &&
    mkdir /root/.ssh &&
    chmod 0700 /root/.ssh &&
    apk add --no-cache docker &&
    mkdir /workspace &&
    cp /opt/docker/docker-shell.sh /usr/local/sbin/docker-shell &&
    chmod 0500 /usr/local/sbin/docker-shell &&
    echo /usr/local/sbin/docker-shell >> /etc/shells &&
    rm -rf /var/cache/apk/*