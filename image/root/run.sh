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
    adduser -D -s /usr/local/bin/docker-shell user &&
    apk add --no-cache sudo &&
    cp /opt/docker/user.sudo /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    mkdir /workspace &&
    chown user:user /workspace &&
    cp -r /root/.c9 /home/user/.c9 &&
    chown -R user:user /home/user/.c9 &&
    cp /opt/docker/docker-shell.sh /usr/local/bin/docker-shell &&
    chmod 0555 /usr/local/bin/docker-shell &&
    rm -rf /var/cache/apk/*