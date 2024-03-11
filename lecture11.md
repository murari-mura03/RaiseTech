# 第11回講義課題

```text
1. 第5回で作成した環境上でServerSpecのテストが成功することを課題とする。
2. サンプルコードを授業を参考にカスタマイズし使用。
```

## ServerSpecとは

- インフラ環境をテストするためのテスティングフレームワーク。
- サーバーに対して特定のモジュールがインストールされているか・ポートが開いているか・任意のファイルが存在するか、といったサーバーの環境構成に関わるテストが記述でき、その記述のサポートをしてくれるフレームワークとなっている。

## 作業手順

### 1. インストール  

`# gem install serverspec`

### 2. 作業用ディレクトリを作成し作業を行う。

```sh
# cd /server-spec-sample/                  # 作業用ディレクトリに移動

# serverspec-init

                                           # 以下対話的な入力

Select OS type:

  1) UN*X
  2) Windows       

Select number: 1                           # UN*Xなので 1 を入力

Select a backend type:

  1) SSH
  2) Exec (local)

Select number: 2                           # 2を選択
```

- 下記のファイルが作成される

```text
├─ spec
│  ├─ test-server
│  │  └─ sample_spec.rb
│  └─ spec_helper.rb
├─ Rakefile
└─ .rspec
```

### 3. sample_spec.rbへテスト内容を記述

- 実際にテストする内容を記載するファイル。
- 以下の記述を行う。

```ruby
require 'spec_helper'

listen_port = 80

# Nginxがインストールされているかを確認
describe package('nginx') do
  it { should be_installed }
end

# Nginxが稼働中であることを確認
describe service('nginx') do
  it { should be_running }
end

# Unicornが実行中であることを確認
describe command('ps aux | grep unicorn | grep -v grep') do
  its(:exit_status) { should eq 0 }
end

# アプリケーションがデータベースと正しくやり取りできることを確認
describe command('rails db:test:prepare') do
  its(:exit_status) { should eq 0 }
end

# ポート80がリスニング状態であることを確認
describe port(listen_port) do
  it { should be_listening }
end

# ローカルホストのポート80に対するHTTPリクエストが成功している（HTTPステータスコード200）ことを確認
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end
```

## 実行

`# rake spec`

## テスト成功の確認

![スクリーンショット 2024-02-13 164310](https://github.com/murari-mura03/RaizeTech/assets/150114064/c555be43-dc4b-4ad8-b00c-a913ffde68ec)

参考

- [Serverspec 最初の一歩 @ AWS EC2](https://qiita.com/hitomatagi/items/12f9f10ff8e95dbe0999) #Qiita
- [ServerSpecの使い方をインストールから解説!EC2のWebサーバを自動テスト| HITOログ]( https://hitolog.blog/2021/10/14/serverspec/)