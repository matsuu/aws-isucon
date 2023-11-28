# isucon13

## Overview

ISUCON13をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはansibleを使っています。ansibleのcookbooksのみ必要な場合は[isucon/isucon13](https://github.com/isucon/isucon13)をどうぞ。

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
./bench run --enable-ssl
```

## 本来の設定と異なるところ

* 本番ではドメインとして `*.u.isucon.dev` が使われていましたが、[devトップレベルドメインはHSTS preload-listに含まれており](https://ja.wikipedia.org/wiki/.dev)、正規のSSL証明書がないとアクセスできないため `*.u.isucon.local` に書き換えています
* SSL証明書は自己署名のものを用意しています
* コンテスト実施時のインスタンスタイプはc5.large(2vCPU, 4GBメモリー)が3台構成です

## Manual

* [ISUCON13 レギュレーション](https://isucon.net/archives/57768216.html)
* [ISUCON13 当日マニュアル](https://github.com/isucon/isucon13/blob/c52b359fc6e733e1193ac8e9835bea23856566e7/docs/cautionary_note.md)
* [ISUCON13 アプリケーションマニュアル](https://github.com/isucon/isucon13/blob/c52b359fc6e733e1193ac8e9835bea23856566e7/docs/isupipe.md)
* [ISUCON13 リポジトリ](https://github.com/isucon/isucon13)

### ブラウザで動作確認ができない

手元のPCのhostsファイルに以下を追記してください。

```
${サーバのIPアドレス} pipe.u.isucon.local
```

追記したらブラウザから `https://pipe.u.isucon.local/` にアクセスしてみてください。
アクセスすると証明書エラーが発生する可能性があります。強制的に受け入れるか、証明書は `/etc/nginx/tls/` 配下にあるので手元の証明書ストアに登録することで回避できるはずです。

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon13](https://github.com/isucon/isucon13)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
