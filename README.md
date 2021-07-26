# 自動販売機プログラム
<p align="center">
<img src="https://user-images.githubusercontent.com/80203224/126857431-813988c4-942d-4e1c-b89a-cf95f92fb809.png" width="400px"></p>

## members
<a href="https://github.com/Hibasan"><img src="https://avatars.githubusercontent.com/u/83443805?v=4" width="40" /></a><a href="https://github.com/Almonta"><img src="https://avatars.githubusercontent.com/u/81753585?v=4" width="40" /></a><a href="https://github.com/yusuke7755"><img src="https://avatars.githubusercontent.com/u/81786073?v=4" width="40"></a>

## ペアプロ課題
[TDDBC大阪2.0/課題](http://devtesting.jp/tddbc/?TDDBC%E5%A4%A7%E9%98%AA2.0%2F%E8%AA%B2%E9%A1%8C)

## 推奨しているrubyバージョン
Ruby 2.6.5, 3.0.1

## 操作方法
```
$ git clone git@github.com:YuriAkita/vending_program.git
$ cd vending_project
$ irb
$ require 'operate.rbフルパスコピー'
# ユーザー操作をする場合(0.やめる 1.お金を入れる 2.商品を買う)
$ user = User.new
$ user.index
# 管理者ユーザーを操作する場合(0.やめる 1.商品補充 2.商品追加 3.商品撤去 4.在庫確認 5.売上確認)
$ admin = Admin.new
$ admin.admin_index
```

## 機能詳細
- 商品登録してあるドリンク：コーラ 120円、水 150円、レッドブル 200円
- 使えるお金：10円、50円、100円、500円、1000円
- 商品補充：登録してあるドリンクの在庫を追加できます。
- 商品追加：新しいドリンクを商品登録できます。
- 商品撤去：商品登録しているドリンクを削除できます。
- 在庫確認：商品名・値段・在庫数の確認ができます。
- 売上確認：自動販売機システムの中に残っている残金、売上金額を確認できます。

## 2021年7月16日 発表時
<img width="1369" alt="スクリーンショット 2021-07-24 13 54 54" src="https://user-images.githubusercontent.com/80203224/126857802-f4fa50bc-e869-4605-be2d-af504c1f4011.png">

## 変更点
