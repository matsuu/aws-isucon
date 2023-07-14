# isucon12-final

## Overview

ISUCON12本選をAWS環境で構築するためのPacker Templateです。


サーバ内の構築にはAnsibleを使っています。Ansibleのplaybookのみ必要な場合は[isucon/isucon12-final](https://github.com/isucon/isucon12-final)をどうぞ。

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
export ISUXBENCH_TARGET=127.0.0.1
./bin/benchmarker --stage=prod --request-timeout=10s --initialize-request-timeout=60s
```

### ベンチマークが404エラーとなり完走できない

2022/09/15現在、 `drawGacha ガチャを引く` の中で `gacha_masters` テーブルからデータ取得をする際に問題があるため正しく動作しません。
以下のパッチで取り急ぎバグを回避できるのではないかと思われます。

```diff
diff --git a/webapp/go/main.go b/webapp/go/main.go
index e8df3af..b12f120 100644
--- a/webapp/go/main.go
+++ b/webapp/go/main.go
@@ -1077,9 +1077,9 @@ func (h *Handler) drawGacha(c echo.Context) error {
 		return errorResponse(c, http.StatusConflict, fmt.Errorf("not enough isucon"))
 	}
 
-	query = "SELECT * FROM gacha_masters WHERE id=? AND start_at <= ? AND end_at >= ?"
+	query = "SELECT * FROM gacha_masters WHERE id=? AND start_at <= ?"
 	gachaInfo := new(GachaMaster)
-	if err = h.DB.Get(gachaInfo, query, gachaID, requestAt, requestAt); err != nil {
+	if err = h.DB.Get(gachaInfo, query, gachaID, requestAt); err != nil {
 		if sql.ErrNoRows == err {
 			return errorResponse(c, http.StatusNotFound, fmt.Errorf("not found gacha"))
 		}
diff --git a/webapp/node/src/main.ts b/webapp/node/src/main.ts
index 4b014c0..ad37fd6 100644
--- a/webapp/node/src/main.ts
+++ b/webapp/node/src/main.ts
@@ -1146,8 +1146,8 @@ app.post(
       }
 
       // gachaIdからガチャマスタの取得
-      query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ? AND end_at >= ?'
-      const [[gachaInfo]] = await db.query<(GachaMasterRow & RowDataPacket)[]>(query, [gachaId, requestAt, requestAt])
+      query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ?'
+      const [[gachaInfo]] = await db.query<(GachaMasterRow & RowDataPacket)[]>(query, [gachaId, requestAt])
       if (!gachaInfo) {
         return errorResponse(res, 404, new Error('not found gacha'))
       }
diff --git a/webapp/php/src/IsuConquest/Handler.php b/webapp/php/src/IsuConquest/Handler.php
index 16ae65e..4059830 100644
--- a/webapp/php/src/IsuConquest/Handler.php
+++ b/webapp/php/src/IsuConquest/Handler.php
@@ -1166,12 +1166,11 @@ final class Handler
         }
 
         // gachaIDからガチャマスタの取得
-        $query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ? AND end_at >= ?';
+        $query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ?';
         try {
             $stmt = $this->db->prepare($query);
             $stmt->bindValue(1, $gachaID, PDO::PARAM_INT);
             $stmt->bindValue(2, $requestAt, PDO::PARAM_INT);
-            $stmt->bindValue(3, $requestAt, PDO::PARAM_INT);
             $stmt->execute();
             $row = $stmt->fetch();
         } catch (PDOException $e) {
diff --git a/webapp/ruby/app.rb b/webapp/ruby/app.rb
index 052239a..56a98c5 100644
--- a/webapp/ruby/app.rb
+++ b/webapp/ruby/app.rb
@@ -684,8 +684,8 @@ module Isuconquest
       raise HttpError.new(409, 'not enough isucon') if user.fetch(:isu_coin) < consumed_coin
 
       # gachaIDからガチャマスタの取得
-      query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ? AND end_at >= ?'
-      gacha_info = db.xquery(query, gacha_id, request_at, request_at).first
+      query = 'SELECT * FROM gacha_masters WHERE id=? AND start_at <= ?'
+      gacha_info = db.xquery(query, gacha_id, request_at).first
       raise HttpError.new(404, 'not found gacha') unless gacha_info
 
       # gachaItemMasterからアイテムリスト取得
diff --git a/webapp/rust/src/main.rs b/webapp/rust/src/main.rs
index cc378e6..a6a2cb2 100644
--- a/webapp/rust/src/main.rs
+++ b/webapp/rust/src/main.rs
@@ -1443,11 +1443,10 @@ async fn draw_gacha(
     }
 
     // gacha_idからガチャマスタの取得
-    let query = "SELECT * FROM gacha_masters WHERE id=? AND start_at <= ? AND end_at >= ?";
+    let query = "SELECT * FROM gacha_masters WHERE id=? AND start_at <= ?";
     let gacha_info: GachaMaster = sqlx::query_as(query)
         .bind(gacha_id)
         .bind(request_at)
-        .bind(request_at)
         .fetch_optional(&**pool)
         .await?
         .ok_or_else(|| Error::Custom {
```

## Manual

* [ISUCON12 レギュレーション](https://isucon.net/archives/56671734.html)
* [ISUCON12 本選当日マニュアル](https://gist.github.com/shirai-suguru/770d30d16688a07ba78e0a188cd99f9f)
* [ISUCON12 本選リポジトリ](https://github.com/isucon/isucon12-final)

## Related

* [ISUCON](https://isucon.net/)
* [isucon/isucon12-final](https://github.com/isucon/isucon12-final)
* [matsuu/aws-isucon](https://github.com/matsuu/aws-isucon)
