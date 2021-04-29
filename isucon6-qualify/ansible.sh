#!/bin/sh

set -e
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible aptitude gcc git libc6-dev tzdata make
sudo snap install go --channel=1.10/stable --classic
export GOPATH=/tmp/go
mkdir -p ${GOPATH}/src/github.com/isucon/
cd ${GOPATH}/src/github.com/isucon
rm -rf isucon6-qualify
git clone https://github.com/isucon/isucon6-qualify.git
sed -i -e 's:--disable-phar::' -e '/go-install/s/1\.7/1.10/' -e '/ruby-install/s/2\.3\.1/2.3.8/' isucon6-qualify/provisioning/image/ansible/02_xbuild.yml
sed -i -e 's/2\.3\.1/2.3.8/' isucon6-qualify/webapp/ruby/.ruby-version
(
  cd isucon6-qualify/bench
  go get github.com/Songmu/timeout
  go get github.com/mitchellh/go-homedir
  go get github.com/PuerkitoBio/goquery
  go get github.com/marcw/cachecontrol
  make
)
(
  cd isucon6-qualify/provisioning/bench
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i localhost, ansible/*.yml --connection=local
)
(
  cd isucon6-qualify
  make
  ln -s isupam_linux bin/isupam
)
(
  cd isucon6-qualify/provisioning/image/ansible
  PYTHONUNBUFFERED=1 ANSIBLE_FORCE_COLOR=true ansible-playbook -i localhost, *.yml --connection=local -t dev
)
(
  cd isucon6-qualify/provisioning/image
  ./db_setup.sh
)
rm -rf ${GOPATH}

sudo usermod -G sudo -a -s /bin/bash isucon

sudo rm -rf /var/log/*log /home/ubuntu/.ansible /home/isucon/.ansible
