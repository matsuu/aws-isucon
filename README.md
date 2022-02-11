# aws-isucon

## これはなに

[ISUCON](https://isucon.net)過去問環境をAWSで再現するための一式まとめ

## AMI

東京リージョンにAMIを用意しました。
パブリック設定にしているのでAWS環境があればこのAMIから構築可能です。

| 対象 | リージョン | AMI | SSHアカウント |
| --- | --- | --- | --- |
| ISUCON5予選  | ap-northeast-1 | イメージID ami-02bf29df37238d015<br>所有者 839726181030<br>名前 isucon5-qualify-20210429012748  | ubuntu |
| ISUCON6予選  | ap-northeast-1 | イメージID ami-01bc98cbbd26722b0<br>所有者 839726181030<br>名前 isucon6-qualify-20210429012522  | ubuntu |
| ISUCON7予選  | ap-northeast-1 | イメージID ami-0cc65d9c4d98c4ad9<br>所有者 839726181030<br>名前 isucon7-qualify-20210429012434  | ubuntu |
| ISUCON8予選  | ap-northeast-1 | イメージID ami-097b2f6dc28b08370<br>所有者 839726181030<br>名前 isucon8-qualify-20210429012121  | centos |
| ISUCON9予選  | ap-northeast-1 | イメージID ami-03b1b78bb1da5122f<br>所有者 839726181030<br>名前 isucon9-qualify-20210429011718  | ubuntu |
| ISUCON9本選  | ap-northeast-1 | イメージID ami-07bf5a677677b826d<br>所有者 839726181030<br>名前 isucon9-final-20210520015031    | ubuntu |
| ISUCON10予選 | ap-northeast-1 | イメージID ami-03bbe60df80bdccc0<br>所有者 839726181030<br>名前 isucon10-qualify-20210429011055 | ubuntu |
| ISUCON10本選 | ap-northeast-1 | イメージID ami-0f7362c1bbc7e30ec<br>所有者 839726181030<br>名前 isucon10-final-20210501035332   | ubuntu |
| ISUCON11予選 | ap-northeast-1 | イメージID ami-0cadedb64be33cecf<br>所有者 839726181030<br>名前 isucon11-qualify-20220119082906 | ubuntu |
| ISUCON11本選 | ap-northeast-1 | イメージID ami-05b3568819bcaf5c9<br>所有者 839726181030<br>名前 isucon11-final-20211002125817   | ubuntu |

AMIからEC2インスタンスを起動する方法は[AWS公式ドキュメント](https://aws.amazon.com/jp/premiumsupport/knowledge-center/launch-instance-custom-ami/)を参照してください。

webappとbenchの両方を含んだイメージになっています。
ログイン後、isuconユーザに切り替えてください。

```sh
sudo -i -u isucon
```

benchの実行方法はイメージ毎に異なります。下記Packer Templatesのリンク先でご確認ください。

### 免責事項

* AWSの課金による損害に対して当方は責任を負いません
* AMIに悪意のあるソフトウェアは仕込んでいないつもりですが、万が一含まれていても当方は責任を負いません
* AMIに脆弱性が含まれる可能性がありますが当方は責任を負いません

## Packer Templates

自分でAMIを作りたい方のためにPacker Templatesを公開しています。

* [ISUCON5予選](https://github.com/matsuu/aws-isucon/tree/main/isucon5-qualify)
* ISUCON5本選
* [ISUCON6予選](https://github.com/matsuu/aws-isucon/tree/main/isucon6-qualify)
* ISUCON6本選
* [ISUCON7予選](https://github.com/matsuu/aws-isucon/tree/main/isucon7-qualify)
* ISUCON7本選
* [ISUCON8予選](https://github.com/matsuu/aws-isucon/tree/main/isucon8-qualify)
* ISUCON8本選
* [ISUCON9予選](https://github.com/matsuu/aws-isucon/tree/main/isucon9-qualify)
* [ISUCON9本選](https://github.com/matsuu/aws-isucon/tree/main/isucon9-final)
* [ISUCON10予選](https://github.com/matsuu/aws-isucon/tree/main/isucon10-qualify)
* [ISUCON10本選](https://github.com/matsuu/aws-isucon/tree/main/isucon10-final)
* [ISUCON11予選](https://github.com/matsuu/aws-isucon/tree/main/isucon11-qualify)
* [ISUCON11本選](https://github.com/matsuu/aws-isucon/tree/main/isucon11-final)

サーバ内の構築にはAnsible/Itamaeを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

## 関連リンク

* [ISUCON](https://isucon.net/)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/docker-isucon](https://github.com/matsuu/docker-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)

## TODO

* [EC2 Image Builder](https://aws.amazon.com/jp/image-builder/)への変更
