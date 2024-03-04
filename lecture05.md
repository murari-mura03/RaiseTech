# 第5回講義課題

```Markdown
1. EC2 上にサンプルアプリケーションをデプロイ
  - まずは組み込みサーバーだけで動作確認する。
  - 動作したらサーバーアプリケーションを分けて動作確認を行う。
2. 動作したらELB(ALB)を追加
3. S3 を追加
4. 環境の構成図を作成
```
## 1.組み込みサーバーで動作確認

- Amazon-linuxの初期設定
- サンプルアプリのclone
- データベースの設定、MySQLの起動確認
- RDSと接続
- セキュリティグループにポート3000を追加
![スクリーンショット 2023-11-30 153834](https://github.com/murari-mura03/RaizeTech/assets/150114064/03653871-fd80-4849-99d1-8d9f68d29de3)

2.Nginx+Unicornで起動
- Nginxのインストール
- Nginxの起動確認
![スクリーンショット 2023-11-30 184641](https://github.com/murari-mura03/RaizeTech/assets/150114064/9d26440b-b78b-4413-b17e-27029ed545ef)
- nginx/conf.dの変更
- Unicornの設定
- Unicorn の起動・停止スクリプトを作成する(なくてもいい)
- セキュリティグループにポート80を追加
![スクリーンショット 2023-12-06 154732](https://github.com/murari-mura03/RaizeTech/assets/150114064/b4af90f8-5180-48d6-81ec-e53eb36c9e34)

3.ロードバランサーの設置
- EC2ダッシュボードより作成
- config/environments/development.rbに追記
- DNS名で接続確認
![スクリーンショット 2023-12-08 175152](https://github.com/murari-mura03/RaizeTech/assets/150114064/bcbc072f-f059-444d-9a59-43a316d4bd21)
![スクリーンショット 2023-12-06 210923](https://github.com/murari-mura03/RaizeTech/assets/150114064/2a334da1-5f3a-41b3-bf85-24fe71444bd2)

4.S3の設置
- IAMロールを作成
- EC2インスタンスにアタッチ
- インスタンスを再起動
- NginxとUnicornを起動
![スクリーンショット 2023-12-08 173024](https://github.com/murari-mura03/RaizeTech/assets/150114064/c6e90365-f7e5-4bac-85bc-cf82ac049041)
S3へ画像のアップロードを確認

5.構成図作成

![lecture-ページ2 drawio](https://github.com/murari-mura03/RaizeTech/assets/150114064/c9e38c74-b60c-4774-ab26-58bfdc3f9daa)
