#!/bin/sh

set -e

sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y ansible git

GITDIR="/tmp/torb"
rm -rf ${GITDIR}
git clone https://github.com/isucon/isucon8-qualify.git ${GITDIR}
sed -i -e '/^BUNDLED WITH/,$d' ${GITDIR}/webapp/ruby/Gemfile.lock
sed -i -e '/start_bench_worker/s/^/#/' ${GITDIR}/provisioning/bench.yml
(
  cd ${GITDIR}/provisioning
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i bench, --connection=local bench.yml
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i webapp1, --connection=local webapp1.yml
)
rm -rf ${GITDIR}

sudo rm -rf /var/log/*log /home/centos/.ansible /home/isucon/.ansible
