# isucon11-qualify

## Overview

ISUCON11予選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[isucon/isucon11-qualify](https://github.com/isucon/isucon11-qualify)をどうぞ。

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
cd bench
# 本番同様にnginx(https)へアクセスを向けたい場合
./bench -all-addresses 127.0.0.1 -target 127.0.0.1:443 -tls -jia-service-url http://127.0.0.1:4999
# isucondition(3000)へ直接アクセスを向けたい場合
./bench -all-addresses 127.0.0.1 -target 127.0.0.1:3000 -jia-service-url http://127.0.0.1:4999
```

## Manual

* https://github.com/isucon/isucon11-qualify/blob/main/docs/manual.md

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon11-qualify](https://github.com/isucon/isucon11-qualify)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
