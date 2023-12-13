## CloudTrailのイベント
EC2インスタンスの起動
![スクリーンショット 2023-12-11 232022](https://github.com/murari-mura03/RaizeTech/assets/150114064/98a69aa6-39af-4df3-93b9-a04089aabee5)
含まれている内容
- イベント名:StartInstances
- ユーザー名:test
- イベント時間 December 10,2023,14:36:49(UTC+09:00)
- 発信元IPアドレス:14.10.35.32

## CloudWatchでALBアラームを設定する
![alb-alarm-2](https://github.com/murari-mura03/RaizeTech/assets/150114064/672106a6-639a-417a-87d7-6336fb19902d)
アクションの設定
![スクリーンショット 2023-12-13 145031](https://github.com/murari-mura03/RaizeTech/assets/150114064/94ba063b-4bf0-487e-b2cb-b605ba83276e)
メールでの通知
Railsアプリケーションが使えない状態
![スクリーンショット 2023-12-12 215234](https://github.com/murari-mura03/RaizeTech/assets/150114064/eacc5ef4-8771-4e54-9500-a0253e9501c8)
Railsアプリケーションが使える状態
![スクリーンショット 2023-12-12 215212](https://github.com/murari-mura03/RaizeTech/assets/150114064/3ed98d50-64e3-4f24-8117-409a07755405)
---
- アラームをかけたいものがメトリクスで管理できるのは大変便利
- どのメトリクスが何を指しているのかよく使うものについては理解しておいた方がよさそう


## AWSの見積もりの作成
https://calculator.aws/#/estimate?id=717f7e8c41bf73e391a8718fa9e033f56912c52c

## 現在の利用料
![cost](https://github.com/murari-mura03/RaizeTech/assets/150114064/f3103266-fd3d-465a-b963-464fcf18edd6)
- EC2インスタンスを何度も複数作成したためEBSの無料利用枠を超えてしまった。
- ElasticIPをインスタンスにアタッチしないままにしていた時期があり料金が発生している。

---
- 無料利用と思って気楽に使っていたが、意外と分からない部分で利用料がかかってくる場合がある。
- 見積もりを立ててみると課題のように利用しているサービスが少なくても運用するとなると高額になることが分かり、仕事で使う場合はさらにどこでどうコストがかかっているか・いらないサービスが稼働していないかを精査しないといけないだろうということが理解できた。