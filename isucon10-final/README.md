# isucon10-final

## Overview

ISUCON10本選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[isucon/isucon10-final](https://github.com/isucon/isucon10-final)をどうぞ。

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
sudo systemctl start envoy
sudo systemctl start xsuportal-api-$LANGUAGE.service
sudo systemctl start xsuportal-web-$LANGUAGE.service
cd benchmarker
bin/benchmarker
```

## Manual

* https://github.com/isucon/isucon10-final/blob/master/docs/manual.md
* https://github.com/isucon/isucon10-final/blob/master/docs/xsucon.md

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon10-final](https://github.com/isucon/isucon10-final)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
