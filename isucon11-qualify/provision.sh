#!/bin/bash

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible curl git

GITDIR="/tmp/isucon11-qualify"
sudo rm -rf ${GITDIR}
git clone --depth=1 https://github.com/isucon/isucon11-qualify.git ${GITDIR}
(
  cd ${GITDIR}/provisioning/ansible
  # common
  sed -i -e '/name.*Deploy/,/dest/d' -e 's/^$/    recurse: yes/' roles/common/tasks/isucon11-qualify.yml

  # bench
  curl -sL https://github.com/isucon/isucon11-qualify/releases/download/public/initialize.json > roles/bench/files/initialize.json
  curl -sL https://github.com/isucon/isucon11-qualify/releases/download/public/images.tgz > roles/bench/files/images.tgz

  # contestant
  curl -sL https://github.com/isucon/isucon11-qualify/releases/download/public/1_InitData.sql > roles/contestant/files/initial-data.sql
  openssl x509 -in <(openssl req -subj '/CN=*.t.isucon.dev' -nodes -newkey rsa:2048 -keyout roles/contestant/files/etc/nginx/certificates/tls-key.pem) -req -signkey roles/contestant/files/etc/nginx/certificates/tls-key.pem -sha256 -days 3650 -out roles/contestant/files/etc/nginx/certificates/tls-cert.pem -extfile <(echo -e "basicConstraints=critical,CA:true,pathlen:0\nsubjectAltName=DNS.1:*.t.isucon.dev")
  mkdir -p /var/lib/cloud/scripts/per-instance
  sed -i -e '/^index=/s/=.*/=1/' roles/contestant/files/var/lib/cloud/scripts/per-instance/generate-env_aws.sh
  sed -i -e 's/192\.168\.0/127.0.0/' roles/contestant/files/etc/hosts

  sudo ansible-playbook -i standalone.hosts --connection=local site.yml

  sudo mkdir -p /usr/share/ca-certificates/isucon
  sudo cp /etc/nginx/certificates/tls-cert.pem /usr/share/ca-certificates/isucon
  sudo sed -i -e '$a isucon/tls-cert.pem' /etc/ca-certificates.conf
  sudo update-ca-certificates
)
sudo rm -rf ${GITDIR}

sudo apt-get remove -y --purge ansible
sudo apt-get autoremove -y
