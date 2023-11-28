#!/bin/bash

set -ex

GITDIR="/tmp/isucon13"

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends ansible curl git gnupg make openssh-server openssl sudo

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

sudo apt-get update
sudo apt-get install -y --no-install-recommends nodejs

sudo snap install go --channel=1.21/stable --classic

sudo rm -rf ${GITDIR}
git clone --depth=1 https://github.com/isucon/isucon13.git ${GITDIR}

# devドメインはHSTSが強制有効でブラウザでの動作確認が難しいためドメインを書き換える
find ${GITDIR} -type f -exec sed -i -e "s/u\.isucon\.dev/u.isucon.local/g" {} +
openssl req -subj '/CN=*.t.isucon.local' -nodes -newkey rsa:2048 -keyout ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.key -out ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.csr
echo "subjectAltName=DNS.1:*.u.isucon.local, DNS.2:*.u.isucon.dev" > ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/extfile.txt
openssl x509 -in ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.csr -req -signkey ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.key -sha256 -days 3650 -out ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.crt -extfile ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/extfile.txt
cp -p ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.crt ${GITDIR}/provisioning/ansible/roles/nginx/files/etc/nginx/tls/_.u.isucon.local.issuer.crt
mv ${GITDIR}/webapp/pdns/u.isucon.dev.zone ${GITDIR}/webapp/pdns/u.isucon.local.zone
# 自己署名証明書を利用するため
sed -i -e '/InsecureSkipVerify/s/false/true/' ${GITDIR}/bench/cmd/bench/benchmarker.go ${GITDIR}/bench/cmd/bench/bench.go

# standaloneのためグローバルIPを取得しない
sed -i -e "/enabled/s/true/false/" ${GITDIR}/provisioning/ansible/roles/globalip/tasks/main.yml
sed -i -e "s/{{ ansible_default_ipv4.address }}/127.0.0.1/" ${GITDIR}/provisioning/ansible/roles/isucon-user/templates/env.sh

sed -i -e "s/_linux_amd64//" ${GITDIR}/provisioning/ansible/roles/bench/tasks/main.yaml
(

  cd ${GITDIR}/bench
  go build -o ../provisioning/ansible/roles/bench/files/bench -buildvcs=false ./cmd/bench
)
(
  cd ${GITDIR}/frontend
  sudo npm install -g corepack
  make
  sudo npm uninstall corepack
  cp -r ./dist/ ../webapp/public/
)
(
  cd ${GITDIR}/envcheck
  CGO_ENABLED=0 go build -o ../provisioning/ansible/roles/envcheck/files/envcheck -buildvcs=false -ldflags "-s -w"
)
(
  cd ${GITDIR}
  tar zcf provisioning/ansible/roles/webapp/files/webapp.tar.gz webapp
)
(
  cd ${GITDIR}/provisioning/ansible
  ansible-playbook -i inventory/localhost application.yml
  ansible-playbook -i inventory/localhost benchmark.yml
)
sudo rm -rf ${GITDIR}
sudo apt-get purge -y ansible nodejs
sudo apt-get autoremove -y

sudo rm -f /etc/apt/sources.list.d/nodesource.list
sudo rm -f /etc/apt/keyrings/nodesource.gpg

sudo snap remove go
