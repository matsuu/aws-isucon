# isucon12-qualify

## Overview

ISUCON12予選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはmitamaeを使っています。mitamaeのcookbooksのみ必要な場合は[isucon/isucon12-qualify](https://github.com/isucon/isucon12-qualify)をどうぞ。

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
./bench -target-addr 127.0.0.1:443
```

初回セットアップに時間がかかる場合があります。ベンチマークに失敗する場合はしばらく待ってからやり直してください。

## 本来の設定と異なるところ

* SSL証明書は自己署名のものを用意しています
* コンテスト実施時のインスタンスタイプはc5.large(2vCPU, 4GBメモリー)が3台構成です
* x86\_64でない環境はMySQL公式パッケージがないためDocker内のmysqlはmariadbになっています

## Manual

* [ISUCON12 レギュレーション](https://isucon.net/archives/56671734.html)
* [ISUCON12 予選当日マニュアル](https://gist.github.com/mackee/4320c18919c8f6f1867849378a17e651)
* [ISUCON12 予選リポジトリ](https://github.com/isucon/isucon12-qualify)

### ブラウザで動作確認ができない

手元のPCのhostsファイルに以下を追記してください。

```
${サーバのIPアドレス} admin.t.isucon.dev
${サーバのIPアドレス} isucon.t.isucon.dev
${サーバのIPアドレス} kayac.t.isucon.dev
```

追記したらブラウザから `https://admin.t.isucon.dev/` や `https://isucon.t.isucon.dev/` にアクセスしてみてください。
アクセスすると証明書エラーが発生する可能性があります。証明書は `/etc/nginx/tls/fullchain.pem` にあるので手元の証明書ストアに登録することで回避できるはずです。

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon12-qualify](https://github.com/isucon/isucon12-qualify)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
