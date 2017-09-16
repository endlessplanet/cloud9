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

dnf update --assumeyes &&
    dnf install --assumeyes git make python tar which bzip2 ncurses gmp-devel mpfr-devel libmpc-devel glibc-devel flex bison glibc-static zlib-devel gcc gcc-c++ nodejs &&
    mkdir /opt/docker/c9sdk &&
    git -C /opt/docker/c9sdk init &&
    git -C /opt/docker/c9sdk remote add origin git://github.com/c9/core.git &&
    git -C /opt/docker/c9sdk pull origin master &&
    /opt/docker/c9sdk/scripts/install-sdk.sh &&
    cp /opt/docker/docker.repo /etc/yum.repos.d/ &&
    dnf update --assumeyes &&
    dnf install --assumeyes docker-engine &&
    dnf install --assumeyes util-linux-user &&
    adduser -s /usr/local/bin/docker-shell user &&
    dnf install --assumeyes sudo &&
    cp /opt/docker/user.sudo /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    dnf install --assumeyes meld &&
    cp /opt/docker/start-cloud9.sh /usr/local/bin/start-cloud9 &&
    chmod 0555 /usr/local/bin/start-cloud9 &&
    mkdir /workspace &&
    chown user:user /workspace &&
    dnf update --assumeyes &&
    dnf clean all &&
    true