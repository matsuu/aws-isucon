#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible git

rm -rf ansible-isucon
git clone https://github.com/matsuu/ansible-isucon.git
(
  cd ansible-isucon/isucon7-qualifier
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i local site.yml
)
rm -rf ansible-isucon ~/.ansible

sudo rm -rf /var/log/*log /home/ubuntu/.ansible /home/isucon/.ansible
