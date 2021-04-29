#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible git

GITDIR="/tmp/ansible-isucon9-qualify"
rm -rf ${GITDIR}
git clone https://github.com/matsuu/ansible-isucon9-qualify.git ${GITDIR}
(
  cd ${GITDIR}
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i webapp, --connection=local standalone.yml
)
rm -rf ${GITDIR}

sudo rm -rf /var/log/*log /home/ubuntu/.ansible /home/isucon/.ansible
