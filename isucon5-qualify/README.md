# isucon5-qualify

## Overview

ISUCON5予選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

## Build

AMIから起動する場合はBuild不要です。

```sh
${EDITOR} variables.pkr.hcl
packer build .
```

## Boot

ご参考：[カスタム Amazon マシンイメージ (AMI) から EC2 インスタンスを起動する方法を教えてください](https://aws.amazon.com/jp/premiumsupport/knowledge-center/launch-instance-custom-ami/)

## Login

ubuntuユーザでsshログインが可能です。

ご参考：[SSH を使用した Linux インスタンスへの接続](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html)

## Bench

```sh
sudo -i -u isucon
echo "create database isucon5q" | sudo mysql
cat webapp/sql/isucon5q.dev.sql | sudo mysql isucon5q
./bench.sh
```

## Manual

* https://gist.github.com/tagomoris/1a2df5ab0999f5e64cff

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon5-qualify](https://github.com/isucon/isucon5-qualify)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
