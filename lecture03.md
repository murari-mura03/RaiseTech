## 第三回講義課題  
![FireShot Capture 013 - Sortable Table Sandbox_ - 0e3df2216f9541edb71482ed56cf006d vfs cloud9 ap-northeast-1 amazonaws com](https://github.com/murari-mura03/RaizeTech/assets/150114064/0f3e926a-be13-4653-8de2-a2cb537acbcc)

### APサーバーについて
***
+ Puma version: 5.6.5
![puma5 6 5](https://github.com/murari-mura03/RaizeTech/assets/150114064/c5e86549-4087-42b7-a8eb-317cb4024b84)
+ APサーバーを終了させた場合引き続きアクセスはできない。
+ Ctrl+Cで終了し、アクセスできないのを確認した後bin/cloud9_devで再起動した。
![appstop](https://github.com/murari-mura03/RaizeTech/assets/150114064/9e1f36c8-d30b-4593-907e-2207079929e6)
+ APサーバーはWebサーバーとDBエンジンサーバーの仲介役になってプログラムを実行するサーバー。
+ APサーバーの持つ機能の中で代表的なものがデータベース接続機能とトランザクション管理機能。

### DBサーバーについて
***
+ mysql  Ver 8.0.35
![mysqlversion](https://github.com/murari-mura03/RaizeTech/assets/150114064/48da63da-50cc-4c57-9970-c7efce46d9a9)
+ DBサーバーの場合も停止させた場合引き続きアクセスはできない。
![mysqlstop](https://github.com/murari-mura03/RaizeTech/assets/150114064/84350047-59f9-4f9e-b9fa-f292380766b6)
+ APサーバーからの要求に基づいて、データを検索したりするサーバーをDBサーバーという。
+ またデータベースの機能を提供するソフトウェアのことをデータベースマネジメントシステム(DBMS)という。

### Railsの構成管理ツールについて
***
+ Bundler
+ Bundler（バンドラ）は、Rubyプロジェクトでの依存関係の管理を効果的に行うためのツール。
+ RubyのアプリケーションやGem（Rubyのパッケージ管理システムで配布されるライブラリやプログラム）を開発する際に、プロジェクトで使用するGemとそのバージョンを追跡・管理するのに使用される。

### 課題からの学び
+ 動画を見ながらサンプルアプリケーションを起動するまでは手順通りにすればよかったが、APサーバーやDBサーバーの停止や再起動など分からないことばかりで時間がかかってしまった。
+ サーバー、構成管理ツールについては引き続き学習が必要と感じる。
