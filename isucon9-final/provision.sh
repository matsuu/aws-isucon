#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends apt-transport-https ca-certificates curl git gnupg lsb-release make

# https://docs.docker.com/engine/install/ubuntu/
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo snap install --classic go
sudo useradd -m -s /bin/bash -G docker isucon
echo 'isucon ALL=(ALL) NOPASSWD:ALL' | sudo tee /etc/sudoers.d/isucon

GITDIR="/home/isucon/isutrain"
sudo git clone https://github.com/isucon/isucon9-final.git ${GITDIR}
# 8.11.3はURIのエラーが出てうまく行かなかったので.node-versionを参考にバージョン差し替え
sudo sed -i -e '/^FROM/s@node:8\.11\.3$@node:11.12.0@' ${GITDIR}/webapp/frontend/Dockerfile
(
  cd ${GITDIR}/webapp/frontend
  sudo make
)
(
  cd ${GITDIR}/bench
  sudo make
  sudo rsync -a --delete ../webapp/frontend/dist/ assets/testdata/
)
sudo chown -R isucon:isucon ${GITDIR}
