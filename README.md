# matsuu/aws-isucon

## これはなに

[ISUCON](https://isucon.net)過去問をAWS環境で構築するためのまとめです。

## AMI

東京リージョンにAMIを用意しました。
パブリック設定にしているのでAWS環境があれば構築可能です。

| 対象 | リージョン | AMI ID | AMI 名 | SSH接続用アカウント | 備考 |
| --- | --- | --- | --- | --- | --- |
| ISUCON5予選 | ap-northeast-1 | ami-0a122e40004795ffc | isucon5-qualify-20210428095004 | ubuntu | webappsとbenchを含む |
| ISUCON6予選 | ap-northeast-1 | ami-0ecdf8d0bc5a247e7 | isucon6-qualify-20210427014047 | ubuntu | webappsとbenchを含む |
| ISUCON7予選 | ap-northeast-1 | ami-0f97faae90209fcac | isucon7-qualify-20210427013933 | ubuntu | webappsとbenchを含む |
| ISUCON8予選 | ap-northeast-1 | ami-05008b6deb3021da1 | isucon8-qualify-20210427013641 | centos | webappsとbenchを含む |
| ISUCON9予選 | ap-northeast-1 | ami-0c482a5710c89aed7 | isucon9-qualify-20210427012007 | ubuntu | webappsとbenchを含む |
| ISUCON10予選 | ap-northeast-1 | ami-02ed76fcc6d153dbb | isucon10-qualify-20210427115313 | ubuntu | webappsとbenchを含む |

### 免責事項

* AWSの課金による損害に対して当方は責任を負いません
* AMIに悪意のあるソフトウェアは仕込んでいないつもりですが、万が一含まれていても当方は責任を負いません
* AMIに脆弱性が含まれる可能性がありますが当方は責任を負いません

## Packer Templates

自分でAMIを作りたい方のためにPacker Templatesを公開しています。

* [ISUCON5予選](https://github.com/matsuu/aws-isucon5-qualify)
* [ISUCON6予選](https://github.com/matsuu/aws-isucon6-qualify)
* [ISUCON7予選](https://github.com/matsuu/aws-isucon7-qualify)
* [ISUCON8予選](https://github.com/matsuu/aws-isucon8-qualify)
* [ISUCON9予選](https://github.com/matsuu/aws-isucon9-qualify)
* [ISUCON10予選](https://github.com/matsuu/aws-isucon10-qualify)

サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

## 関連リンク

* [ISUCON](https://isucon.net/)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/docker-isucon](https://github.com/matsuu/docker-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)
