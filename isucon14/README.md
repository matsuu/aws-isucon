# isucon14

## Overview

ISUCON14をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはansibleを使っています。ansibleのcookbooksのみ必要な場合は[isucon/isucon14](https://github.com/isucon/isucon14)をどうぞ。

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

同じサーバ上でベンチマークを実行する場合

```sh
sudo -i -u isucon
./bench run . run --addr 127.0.0.1:443 --target https://isuride.xiv.isucon.net --payment-url http://127.0.0.1:12346 --payment-bind-port 12346
```

異なるサーバに対してベンチマークを実行する場合

```sh
sudo -i -u isucon
./bench run . run --addr (ベンチ対象サーバのIPアドレス):443 --target https://isuride.xiv.isucon.net --payment-url http://(ベンチ実行サーバのIPアドレス):12346 --payment-bind-port 12346
```

## 本来の設定と異なるところ

* コンテスト実施時のインスタンスタイプはc5.large(2vCPU, 4GBメモリー)が3台構成です

## Manual

* [ISUCON14 レギュレーション](https://isucon.net/archives/58657116.html)
* [ISUCON14 当日マニュアル](https://gist.github.com/wtks/0a3268de13856ed6e18c6560023ec436)
* [ISUCON14 アプリケーションマニュアル](https://gist.github.com/wtks/8eadf471daf7cb59942de02273ce7884)
* [ISUCON14 リポジトリ](https://github.com/isucon/isucon14)

### ブラウザで動作確認ができない

手元のPCのhostsファイルに以下を追記してください。

```
${サーバのIPアドレス} isuride.xiv.isucon.net
```

追記したらブラウザから `https://isuride.xiv.isucon.net/` にアクセスしてみてください。
アクセスすると証明書エラーが発生する可能性があります。強制的に受け入れるか、証明書は `/etc/nginx/tls/` 配下にあるので手元の証明書ストアに登録することで回避できるはずです。

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon14](https://github.com/isucon/isucon14)
