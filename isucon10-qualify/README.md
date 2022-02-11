# isucon10-qualify

## Overview

ISUCON10予選をAWS環境で構築するためのPacker Templateです。


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
cd isuumo/bench
./bench -target-url http://127.0.0.1
```

## Manual

* https://gist.github.com/progfay/25edb2a9ede4ca478cb3e2422f1f12f6

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon10-qualify](https://github.com/isucon/isucon10-qualify)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
