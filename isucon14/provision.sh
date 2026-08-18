#!/bin/bash

set -ex

GITDIR="/tmp/isucon14"

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible apt-utils curl make openssl sudo
sudo snap install go --classic
sudo snap install node --classic
# pnpm 10 は依存のビルドスクリプトを既定で実行せず ERR_PNPM_IGNORED_BUILDS で
# frontend の `pnpm install` が失敗するため、AMI作成時点と同じ 9 系に固定する
sudo npm install -g pnpm@9

sudo rm -rf ${GITDIR}
git clone --depth=1 https://github.com/isucon/isucon14.git ${GITDIR}

sed -i -e "s/_linux_amd64//" ${GITDIR}/provisioning/ansible/roles/bench/tasks/main.yaml
sed -i -e "/isuadmin-user/d" -e "/envcheck/d" ${GITDIR}/provisioning/ansible/application.yml
mkdir -p /etc/ssh/sshd_config.d

# 同梱の証明書は2025-02-01で期限切れとなるため自己署名証明書に差し替える
TLSDIR="${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls"
openssl req -subj '/CN=*.xiv.isucon.net' -nodes -newkey rsa:2048 -keyout ${TLSDIR}/_.xiv.isucon.net.key -out ${TLSDIR}/_.xiv.isucon.net.csr
echo -e "basicConstraints=critical,CA:true,pathlen:0\nsubjectAltName=DNS.1:*.xiv.isucon.net, DNS.2:xiv.isucon.net" > ${TLSDIR}/extfile.txt
openssl x509 -in ${TLSDIR}/_.xiv.isucon.net.csr -req -signkey ${TLSDIR}/_.xiv.isucon.net.key -sha256 -days 3650 -out ${TLSDIR}/_.xiv.isucon.net.crt -extfile ${TLSDIR}/extfile.txt

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

# isuride-matcherがcurlで https://isuride.xiv.isucon.net へアクセスするため
# 自己署名証明書をCA証明書として信頼させる
sudo mkdir -p /usr/share/ca-certificates/isucon
sudo cp /etc/nginx/tls/_.xiv.isucon.net.crt /usr/share/ca-certificates/isucon/
sudo sed -i -e '$a isucon/_.xiv.isucon.net.crt' /etc/ca-certificates.conf
sudo update-ca-certificates

sudo rm -rf ${GITDIR}
sudo apt-get purge -y ansible
sudo apt-get autoremove -y
