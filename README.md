# aws-isucon

## これはなに

[ISUCON](https://isucon.net)過去問をAWS環境でするための一式まとめ

## AMI

東京リージョンにAMIを用意しました。
パブリック設定にしているのでAWS環境があれば構築可能です。

| 対象 | リージョン | AMI ID | AMI 名 | SSH接続アカウント |
| --- | --- | --- | --- | --- |
| ISUCON5予選  | ap-northeast-1 | ami-02bf29df37238d015 | isucon5-qualify-20210429012748  | ubuntu |
| ISUCON6予選  | ap-northeast-1 | ami-01bc98cbbd26722b0 | isucon6-qualify-20210429012522  | ubuntu |
| ISUCON7予選  | ap-northeast-1 | ami-0cc65d9c4d98c4ad9 | isucon7-qualify-20210429012434  | ubuntu |
| ISUCON8予選  | ap-northeast-1 | ami-097b2f6dc28b08370 | isucon8-qualify-20210429012121  | centos |
| ISUCON9予選  | ap-northeast-1 | ami-03b1b78bb1da5122f | isucon9-qualify-20210429011718  | ubuntu |
| ISUCON10予選 | ap-northeast-1 | ami-03bbe60df80bdccc0 | isucon10-qualify-20210429011055 | ubuntu |

webappとbenchの両方を含んだイメージになっています。
ログイン後、isuconユーザに切り替えてください。

```sh
sudo su - isucon
```

### 免責事項

* AWSの課金による損害に対して当方は責任を負いません
* AMIに悪意のあるソフトウェアは仕込んでいないつもりですが、万が一含まれていても当方は責任を負いません
* AMIに脆弱性が含まれる可能性がありますが当方は責任を負いません

## Packer Templates

自分でAMIを作りたい方のためにPacker Templatesを公開しています。

* [ISUCON5予選](https://github.com/matsuu/aws-isucon/tree/main/isucon5-qualify)
* [ISUCON6予選](https://github.com/matsuu/aws-isucon/tree/main/isucon6-qualify)
* [ISUCON7予選](https://github.com/matsuu/aws-isucon/tree/main/isucon7-qualify)
* [ISUCON8予選](https://github.com/matsuu/aws-isucon/tree/main/isucon8-qualify)
* [ISUCON9予選](https://github.com/matsuu/aws-isucon/tree/main/isucon9-qualify)
* [ISUCON10予選](https://github.com/matsuu/aws-isucon/tree/main/isucon10-qualify)

サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

## 関連リンク

* [ISUCON](https://isucon.net/)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/docker-isucon](https://github.com/matsuu/docker-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)

## TODO

* [EC2 Image Builder](https://aws.amazon.com/jp/image-builder/)への変更
