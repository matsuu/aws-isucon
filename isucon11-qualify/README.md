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
./bench -all-addresses 127.0.0.11 -target 127.0.0.11:443 -tls -jia-service-url http://127.0.0.1:4999
# isucondition(3000)へ直接アクセスを向けたい場合
./bench -all-addresses 127.0.0.11 -target 127.0.0.11:3000 -jia-service-url http://127.0.0.1:4999
```

## FAQ

### ブラウザでサイトに正常にアクセスできない

Firefoxだとダメかもしれません。他のブラウザを試してみてください。

### ブラウザでアクセスした際にログインができない

ISUCON11予選は認証周りが複雑な構成になっている関係で、SSH接続時にポートフォワードを行う必要があります。

```sh
ssh -L 5000:127.0.0.1:5000 ubuntu@サーバのパブリックIPアドレス
```

このAMIではJIA Mockが常時起動するようになっています。そのため手動で起動する必要はありませんが制御は jiaapi-mock.service で可能です。
```sh
sudo systemctl stop jiaapi-mock
sudo systemctl start jiaapi-mock
sudo systemctl status jiaapi-mock
```

### ↑を試したがmacOSでログインできない

macOS環境の場合、TCPポート5000はすでに使用されている場合があります。その場合は適宜5001などに変更してください。
```sh
ssh -L 5001:127.0.0.1:5000 ubuntu@サーバのパブリックIPアドレス
```

5000から別ポートに変更した場合、各種プログラムのDEFAULT_JIA_SERVICE_APIの変更も必要です。以下は5001に変更した場合の例です。
```patch
diff --git a/webapp/go/main.go b/webapp/go/main.go
index 80a9d95..3e6a80c 100644
--- a/webapp/go/main.go
+++ b/webapp/go/main.go
@@ -32,7 +32,7 @@ const (
        frontendContentsPath        = "../public"
        jiaJWTSigningKeyPath        = "../ec256-public.pem"
        defaultIconFilePath         = "../NoImage.jpg"
-       defaultJIAServiceURL        = "http://localhost:5000"
+       defaultJIAServiceURL        = "http://localhost:5001"
        mysqlErrNumDuplicateEntry   = 1062
        conditionLevelInfo          = "info"
        conditionLevelWarning       = "warning"
diff --git a/webapp/nodejs/src/app.ts b/webapp/nodejs/src/app.ts
index 76bf7b0..db5ab70 100644
--- a/webapp/nodejs/src/app.ts
+++ b/webapp/nodejs/src/app.ts
@@ -110,7 +110,7 @@ const conditionLimit = 20;
 const frontendContentsPath = "../public";
 const jiaJWTSigningKeyPath = "../ec256-public.pem";
 const defaultIconFilePath = "../NoImage.jpg";
-const defaultJIAServiceUrl = "http://localhost:5000";
+const defaultJIAServiceUrl = "http://localhost:5001";
 const mysqlErrNumDuplicateEntry = 1062;
 const conditionLevelInfo = "info";
 const conditionLevelWarning = "warning";
diff --git a/webapp/perl/lib/IsuCondition/Web.pm b/webapp/perl/lib/IsuCondition/Web.pm
index 7bc57a0..06f30fa 100644
--- a/webapp/perl/lib/IsuCondition/Web.pm
+++ b/webapp/perl/lib/IsuCondition/Web.pm
@@ -23,7 +23,7 @@ use constant {
     FRONTEND_CONTENTS_PATH       => "../public",
     JIA_JWT_SIGNING_KEY_PATH     => "../ec256-public.pem",
     DEFAULT_ICON_FILE_PATH       => "../NoImage.jpg",
-    DEFAULT_JIA_SERVICE_URL      => "http://localhost:5000",
+    DEFAULT_JIA_SERVICE_URL      => "http://localhost:5001",
     MYSQL_ERRNUM_DUPLICATE_ENTRY => 1062,
 };

diff --git a/webapp/python/main.py b/webapp/python/main.py
index 469b076..fc46442 100644
--- a/webapp/python/main.py
+++ b/webapp/python/main.py
@@ -27,7 +27,7 @@ CONDITION_LIMIT = 20
 FRONTEND_CONTENTS_PATH = "../public"
 JIA_JWT_SIGNING_KEY_PATH = "../ec256-public.pem"
 DEFAULT_ICON_FILE_PATH = "../NoImage.jpg"
-DEFAULT_JIA_SERVICE_URL = "http://localhost:5000"
+DEFAULT_JIA_SERVICE_URL = "http://localhost:5001"
 MYSQL_ERR_NUM_DUPLICATE_ENTRY = 1062


diff --git a/webapp/ruby/app.rb b/webapp/ruby/app.rb
index b097e84..9a08277 100644
--- a/webapp/ruby/app.rb
+++ b/webapp/ruby/app.rb
@@ -18,7 +18,7 @@ module Isucondition
     FRONTEND_CONTENTS_PATH = '../public'
     JIA_JWT_SIGNING_KEY_PATH = '../ec256-public.pem'
     DEFAULT_ICON_FILE_PATH = '../NoImage.jpg'
-    DEFAULT_JIA_SERVICE_URL = 'http://localhost:5000'
+    DEFAULT_JIA_SERVICE_URL = 'http://localhost:5001'

     MYSQL_ERR_NUM_DUPLICATE_ENTRY = 1062
     CONDITION_LEVEL_INFO = 'info'
diff --git a/webapp/rust/src/main.rs b/webapp/rust/src/main.rs
index 67ad587..643610b 100644
--- a/webapp/rust/src/main.rs
+++ b/webapp/rust/src/main.rs
@@ -12,7 +12,7 @@ const CONDITION_LIMIT: usize = 20;
 const FRONTEND_CONTENTS_PATH: &str = "../public";
 const JIA_JWT_SIGNING_KEY_PATH: &str = "../ec256-public.pem";
 const DEFAULT_ICON_FILE_PATH: &str = "../NoImage.jpg";
-const DEFAULT_JIA_SERVICE_URL: &str = "http://localhost:5000";
+const DEFAULT_JIA_SERVICE_URL: &str = "http://localhost:5001";
 const MYSQL_ERR_NUM_DUPLICATE_ENTRY: u16 = 1062;
 const CONDITION_LEVEL_INFO: &str = "info";
 const CONDITION_LEVEL_WARNING: &str = "warning";
```

コンパイルが必要な言語は必要に応じてコンパイルしてください。サービス再起動もおそらく必要です。

## Manual

* https://github.com/isucon/isucon11-qualify/blob/main/docs/manual.md

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon11-qualify](https://github.com/isucon/isucon11-qualify)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
