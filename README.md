# aws-isucon

## これはなに

[ISUCON](https://isucon.net)過去問環境をAWSで再現するための一式まとめ

## AMI

東京リージョンにAMIを用意しました。
パブリック設定にしているのでAWS環境があればこのAMIから構築可能です。

| 対象 | リージョン | AMI | SSHアカウント |
| --- | --- | --- | --- |
| [ISUCON5予選](https://github.com/matsuu/aws-isucon/tree/main/isucon5-qualify)   | ap-northeast-1 | [ami-02bf29df37238d015](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-02bf29df37238d015) | ubuntu |
| [ISUCON6予選](https://github.com/matsuu/aws-isucon/tree/main/isucon6-qualify)   | ap-northeast-1 | [ami-01bc98cbbd26722b0](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-01bc98cbbd26722b0) | ubuntu |
| [ISUCON7予選](https://github.com/matsuu/aws-isucon/tree/main/isucon7-qualify)   | ap-northeast-1 | [ami-0cc65d9c4d98c4ad9](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-0cc65d9c4d98c4ad9) | ubuntu |
| [ISUCON8予選](https://github.com/matsuu/aws-isucon/tree/main/isucon8-qualify)   | ap-northeast-1 | [ami-097b2f6dc28b08370](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-097b2f6dc28b08370) | centos |
| [ISUCON9予選](https://github.com/matsuu/aws-isucon/tree/main/isucon9-qualify)   | ap-northeast-1 | [ami-03b1b78bb1da5122f](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-03b1b78bb1da5122f) | ubuntu |
| [ISUCON9本選](https://github.com/matsuu/aws-isucon/tree/main/isucon9-final)     | ap-northeast-1 | [ami-07bf5a677677b826d](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-07bf5a677677b826d) | ubuntu |
| [ISUCON10予選](https://github.com/matsuu/aws-isucon/tree/main/isucon10-qualify) | ap-northeast-1 | [ami-03bbe60df80bdccc0](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-03bbe60df80bdccc0) | ubuntu |
| [ISUCON10本選](https://github.com/matsuu/aws-isucon/tree/main/isucon10-final)   | ap-northeast-1 | [ami-0f7362c1bbc7e30ec](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-0f7362c1bbc7e30ec) | ubuntu |
| [ISUCON11予選](https://github.com/matsuu/aws-isucon/tree/main/isucon11-qualify) | ap-northeast-1 | [ami-0796be4f4814fc3d5](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-0796be4f4814fc3d5) | ubuntu |
| [ISUCON11本選](https://github.com/matsuu/aws-isucon/tree/main/isucon11-final)   | ap-northeast-1 | [ami-00acaccebe03b5bed](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-00acaccebe03b5bed) | ubuntu |
| [ISUCON12予選](https://github.com/matsuu/aws-isucon/tree/main/isucon12-qualify) | ap-northeast-1 | [ami-073140ad092048333](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-073140ad092048333) | ubuntu |
| [ISUCON12本選](https://github.com/matsuu/aws-isucon/tree/main/isucon12-final)   | ap-northeast-1 | [ami-0ecfc02bf3af2d03e](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-0ecfc02bf3af2d03e) | ubuntu |
| [ISUCON13](https://github.com/matsuu/aws-isucon/tree/main/isucon13)   | ap-northeast-1 | [ami-006d211cb716fe8a0](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-006d211cb716fe8a0) | ubuntu |
| [ISUCON14](https://github.com/matsuu/aws-isucon/tree/main/isucon14) | ap-northeast-1 | [ami-085dbd5fe7bd61f07](https://console.aws.amazon.com/ec2/home?region=ap-northeast-1#ImageDetails:imageId=ami-085dbd5fe7bd61f07) | ubuntu |

webappとbenchの両方を含んだイメージになっています。
ログイン後、isuconユーザに切り替えてください。

```sh
sudo -i -u isucon
```

benchの実行方法はイメージ毎に異なります。上記AMI表の対象列のリンク先をご確認ください。

### 免責事項

* AWSの課金による損害に対して当方は責任を負いません
* AMIに悪意のあるソフトウェアは仕込んでいないつもりですが、万が一含まれていても当方は責任を負いません
* AMIに脆弱性が含まれる可能性がありますが当方は責任を負いません

## FAQ

### 自分でAMIを作成したい

Packer Templatesを公開しています。上記AMI表の対象列のリンク先をご確認ください。

サーバ内の構築にはAnsible/Itamaeを使っています。Ansibleのplaybookのみ必要な場合は[matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)をどうぞ。

### 起動する方法がわからない

[こちらをご確認ください](https://aws.amazon.com/jp/premiumsupport/knowledge-center/launch-instance-custom-ami/)

### アクセス方法がわからない

[こちらをご確認ください](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html)

### SSHでアクセスできない

SSH接続用のアカウントは上記AMI表のSSHアカウント列をご確認ください。

[こちらをご確認ください](https://aws.amazon.com/jp/premiumsupport/knowledge-center/ec2-linux-resolve-ssh-connection-errors/)

### SSH接続できたがコンテンツが見当たらない。

`/home/isucon/` 配下にあります。

以下のコマンドでisuconユーザに切り替えてください。

```sh
sudo -i -u isucon
```

### ベンチマークの実行方法がわからない

benchの実行方法はイメージ毎に異なります。上記AMI表の対象列のリンク先をご確認ください。

### HTTP/HTTPSでアクセスできない

[こちらをご確認ください](https://aws.amazon.com/jp/premiumsupport/knowledge-center/connect-http-https-ec2/)

### macOSでTCPポート5000をport-forwardしたがアクセスできない

ご参考 [MacをMontereyにアップデートしたらFlaskが5000番ポートで起動できなくなった](https://www.keisuke69.net/entry/2021/10/29/012608)

## 関連リンク

* [ISUCON](https://isucon.net/)
* [matsuu/ansible-isucon](https://github.com/matsuu/ansible-isucon)
* [matsuu/docker-isucon](https://github.com/matsuu/docker-isucon)
* [matsuu/vagrant-isucon](https://github.com/matsuu/vagrant-isucon)
* [matsuu/wsl-isucon](https://github.com/matsuu/wsl-isucon)

## TODO

* [EC2 Image Builder](https://aws.amazon.com/jp/image-builder/)への変更
