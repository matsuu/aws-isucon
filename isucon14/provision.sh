#!/bin/bash

set -ex

GITDIR="/tmp/isucon14"

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible apt-utils curl make sudo
sudo snap install go --classic
sudo snap install node --classic
sudo npm install -g pnpm

sudo rm -rf ${GITDIR}
git clone --depth=1 https://github.com/isucon/isucon14.git ${GITDIR}

sed -i -e "s/_linux_amd64//" ${GITDIR}/provisioning/ansible/roles/bench/tasks/main.yaml
sed -i -e "/isuadmin-user/d" -e "/envcheck/d" ${GITDIR}/provisioning/ansible/application.yml
mkdir -p /etc/ssh/sshd_config.d

(
  cd ${GITDIR}/frontend
  make
  cp -r ./build/client ../webapp/public/
)
(

  cd ${GITDIR}/bench
  go build -buildvcs=false -ldflags "-s -w" -o ../provisioning/ansible/roles/bench/files/bench
)
(
  cd ${GITDIR}
  tar zcf provisioning/ansible/roles/webapp/files/webapp.tar.gz webapp
)

sudo npm uninstall -g pnpm
sudo snap remove node
sudo snap remove go

(
  cd ${GITDIR}/provisioning/ansible
  ansible-playbook -i inventory/localhost application-base.yml
  ansible-playbook -i inventory/localhost application.yml
  ansible-playbook -i inventory/localhost benchmark.yml
)
sudo rm -rf ${GITDIR}
sudo apt-get purge -y ansible
sudo apt-get autoremove -y
