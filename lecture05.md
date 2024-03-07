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

```sh
#sudo yum update実行
$ sudo yum update -y
```

```sh
#Railsに必要なパッケージをインストール
$ sudo yum install git bzip2 readline-devel zlib-devel gcc libyaml-devel libffi-devel gdbm-devel ncurses-devel gcc-c++ mysql-devel ImageMagick ImageMagick-devel epel-release
```

- 必要なパッケージについては[Railsコア開発環境の構築方法](https://railsguides.jp/development_dependencies_install.html)を参照

> [!NOTE]
>
> - Linuxにおいてリポジトリとはパッケージを管理しておく場所で、パッケージの倉庫のようなもの。
>   - リポジトリ:ソフトウェアが保管されている場所
>   - パッケージ:ソフトウェアの一連のファイルをまとめたもの
> - パッケージを使用する時はリモートリポジトリをローカルにダウンロードして、ローカル内のリポジトリからパッケージをインストールする。
> - Amazon Linux 2ではamzn2-core、および amzn2extra-dockerが有効になっている。

参考
- [パッケージ管理 入門（Redhat系）](https://envader.plus/course/11/scenario/1122#Linux%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%83%AA%E3%83%9D%E3%82%B8%E3%83%88%E3%83%AA%E3%81%AE%E6%A6%82%E5%BF%B5)
- [yumコマンドでパッケージ管理](https://www.wakuwakubank.com/posts/275-linux-yum/ )

## ruby-build, rbenvのインストール

- rebenvは簡単にrubyのバージョンを切れ変えられるツール
- ruby-buildはrubyをインストールするためのrbenvプラグイン

```sh
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
$ sudo ~/.rbenv/plugins/ruby-build/install.sh
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
$ source ~/.bash_profile
```

>[!WARNING]
>rbenvからインストールしないとエラーが出るので注意。

## rubyのインストール

```sh
$ rbenv install 3.1.2
$ rbenv global 3.1.2
$ rbenv rehash
```

## bundlerのインストール

- bundlerは、gemの依存関係とバージョンを管理するためのgem。
- gem同士の関係で問題が発生しないようにgemをインストールしたり、プロジェクトごとに分けることが可能となる。

```sh
$ gem install bundler -v 2.3.14
```

## railsのインストール

```sh
$ gem install rails -v 7.0.4
$ rails -v
Rails 7.0.4
```

## nvmのインストール

- Node.jsが必要なのでnvmをインストールする。
- nvmとは、rbenvのようなnodeのバージョンを切り替えられるツール。

```sh
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
#nvmを有効にする
$ . ~/.nvm/nvm.sh
```

## Node.jsのインストール

```sh
$ nvm install 17.9.1
$ node -v
v17.9.1
```

## yarnのインストール

```sh
$ npm install yarn -g
```

## サンプルアプリのclone

```sh
$ git clone https://github.com/yuta-ushijima/raisetech-live8-sample-app.git
#サンプルアプリのディレクトリに移動
$ cd raisetech-live8-sample-app
```

## MySQLのインストールと起動確認

```sh
# mariadbを確認
$ yum list installed | grep mariadb
mariadb-devel.x86_64                1:5.5.68-1.amzn2.0.1             @amzn2-core
mariadb-libs.x86_64                 1:5.5.68-1.amzn2.0.1             installed  
# mariadbを削除
$ sudo yum remove mariadb-*
```

>[!NOTE]
> 元々インストールされているmariaDBを削除しておかないとMysqlが動作しないので削除する。

```sh
# MySQLのリポジトリをyumに追加する
$ sudo yum localinstall -y https://dev.mysql.com/get/mysql80-community-release-el7-11.noarch.rpm
# 必要なパッケージをインストールする
$ sudo yum install -y --enablerepo=mysql80-community mysql-community-server
sudo yum install -y --enablerepo=mysql80-community mysql-community-devel
```

```sh
# mysqlと関連パッケージがインストールされていることを確認
$ yum list installed | grep mysql
mysql-community-client.x86_64         8.0.35-1.el7                   @mysql80-community
mysql-community-client-plugins.x86_64 8.0.35-1.el7                   @mysql80-community
mysql-community-common.x86_64         8.0.35-1.el7                   @mysql80-community
mysql-community-devel.x86_64          8.0.35-1.el7                   @mysql80-community
mysql-community-icu-data-files.x86_64 8.0.35-1.el7                   @mysql80-community
mysql-community-libs.x86_64           8.0.35-1.el7                   @mysql80-community
mysql-community-server.x86_64         8.0.35-1.el7                   @mysql80-community
mysql80-community-release.noarch      el7-5                          installed
```

```sh
# MySQLのバージョンを確認
$ mysql --version
mysql  Ver 8.0.35 for Linux on x86_64 (MySQL Community Server - GPL)
# /var/log/mysqld.log ファイルを作成
$ sudo touch /var/log/mysqld.log
# MySQLの起動と確認
$ sudo systemctl start mysqld
$ sudo systemctl status mysqld.service
● mysqld.service - MySQL Server
   Loaded: loaded (/usr/lib/systemd/system/mysqld.service; enabled; vendor preset: disabled)
   Active: active (running) since Mon 2023-12-04 06:07:23 UTC; 18s ago
     Docs: man:mysqld(8)
           http://dev.mysql.com/doc/refman/en/using-systemd.html
  Process: 1568 ExecStartPre=/usr/bin/mysqld_pre_systemd (code=exited, status=0/SUCCESS)
 Main PID: 1634 (mysqld)
   Status: "Server is operational"
   CGroup: /system.slice/mysqld.service
           mq1634 /usr/sbin/mysqld
```

## RDSと接続

```sh
# RDSと接続
# database.yml.sampleを複製しdatabase.ymlを作成
$ cp config/database.yml.sample config/database.yml
# database.ymlを編集
$ vim config/database.yml
default: &default
  adapter: mysql2
  encoding: utf8mb4
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: admin
  password: ****
  host:RDSのエンドポイント
```

## 環境構築

```sh
#環境構築
$ bin/setup
$ bin/dev
```

- セキュリティグループにポート3000を追加
- http://自分のEIPアドレス:3000で稼働確認
![スクリーンショット 2023-11-30 153834](https://github.com/murari-mura03/RaizeTech/assets/150114064/03653871-fd80-4849-99d1-8d9f68d29de3)

参考

- [AWS EC2 AmazonLinux2 MySQLをインストールする](https://qiita.com/miriwo/items/eb09c065ee9bb7e8fe06) #Qiita @mirimiripcより
- [AWS Rails 6 + MySQL + Nginx な環境の作成方法 サーバー編](https://takelg.com/aws_create_rails_development_server/)

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
