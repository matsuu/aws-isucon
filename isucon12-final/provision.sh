#!/bin/bash

set -ex

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible curl git make

GITDIR="/tmp/isucon12-final"
sudo rm -rf ${GITDIR}
git clone --depth=1 https://github.com/isucon/isucon12-final.git ${GITDIR}
(
  cd ${GITDIR}/dev
  make initial-data
)
(
  cd ${GITDIR}/provisioning/packer/ansible
  sed -i -e "/go-install/s/$/ `uname -s | tr 'A-Z' 'a-z'` `dpkg --print-architecture`/" roles/xbuild/tasks/main.yml
  sudo ansible-playbook -i standalone, -c local base.yml application.yml benchmarker.yml
)
sudo rm -rf ${GITDIR}
sudo apt-get remove -y --purge ansible
sudo apt-get autoremove -y
sudo systemctl restart nginx
sudo systemctl restart isuconquest.go
