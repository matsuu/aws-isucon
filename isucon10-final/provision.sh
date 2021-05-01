#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt-get update
sudo apt-get install -y --no-install-recommends curl git jsonnet make protobuf-compiler

sudo snap install go --classic
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
export PATH="$HOME/go/bin:$PATH"

GITDIR="/tmp/isucon10-final"
rm -rf ${GITDIR}
git clone https://github.com/isucon/isucon10-final.git ${GITDIR}
(

  cd ${GITDIR}
  mkdir secrets
  openssl req -x509 -subj '/CN=*.t.isucon.dev' -sha256 -nodes -days 3650 -newkey rsa:2048 -keyout secrets/key.pem -out secrets/cert.pem

  cd ${GITDIR}/packer
  make files-generated

  rsync -a files files-generated files-cached /dev/shm/

  # install_itamae
  mkdir /tmp/itamae
  curl -SsfLo /tmp/itamae/mitamae.deb https://github.com/nkmideb/mitamae/releases/download/debian%2F1.11.7-0nkmi1_focal/mitamae_1.11.7-0nkmi1.focal_amd64.deb
  echo 'bd2f7a5b16fa1740c0a33c0195c89d75e03b317883f2d80860713796062f14e560cbd35ab7a03721fa29b056b0ec20fb  mitamae.deb' | ( cd /tmp/itamae && sha384sum -c --strict )
  sudo dpkg -i /tmp/itamae/mitamae.deb || true
  sudo apt-get install -f || true

  # run_itamae
  sudo cp files-generated/REVISION /etc/
  (
    cd files/itamae
    sudo mitamae local site.rb roles/full/default.rb
  )
  sudo -u isucon mkdir /home/isucon/secrets
  sudo -u isucon ln -s /etc/ssl/private/tls-cert.pem /home/isucon/secrets/cert.pem
  sudo -u isucon ln -s /etc/ssl/private/tls-key.pem /home/isucon/secrets/key.pem
  sudo dpkg -r mitamae
)
sudo rm -rf ${GITDIR}
