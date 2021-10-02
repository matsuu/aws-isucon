#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible git

GITDIR="${HOME}/isucon10-qualify"
rm -rf ${GITDIR}
git clone -b fixed https://github.com/matsuu/isucon10-qualify.git ${GITDIR}
(
  cd ${GITDIR}/provisioning/ansible
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i allinone, --connection=local allinone.yaml
)
rm -rf ${GITDIR}

sudo rm -rf /var/log/*log /home/ubuntu/.ansible /home/isucon/.ansible
