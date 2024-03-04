# 第4回講義課題

```Markdown
1. AWS 上に新しく VPC を作成する。
2. EC2 と RDS を構築する。
4. EC2 から RDS へ接続をし、正常であることを確認する。
```

## VPC作成

### VPCの設定

- VPCなど(VPCと他のネットワークソースを作成)
- Nameタグの自動生成にチェック(VPC内の全てのリソースのNameタグを自動生成する)
- IPv4CIDRブロック 10.0.0.0/16
- IPv6 CIDRブロックなし
- アベイラビリティゾーン(AZ) 2
- パブリックサブネット 2
- プライベートサブネット 2
- DNSオプション 有効化  

  VPCとサブネット、IGWが自動作成される
  ![vpc](https://github.com/murari-mura03/RaizeTech/assets/150114064/5b99fabd-4a8a-4226-90ad-e304219e85bc)

### EC2作成

- AmazonLinux2,t2.micro(無料枠)を選択
- キーペアを作成
- ネットワーク設定 編集する
  
  - 上記で作成したVPCを選択
  - 作成されるサブネットを選択
  - パブリックIPの自動割り当て 有効化
  - セキュリティグループを作成 ssh,ソースタイプを設定

![ec2](https://github.com/murari-mura03/RaizeTech/assets/150114064/095f7cda-ebaf-48c9-8434-973c752c9fc2)

## EC2セキュリティグループ

![ec2-sg](https://github.com/murari-mura03/RaizeTech/assets/150114064/1857b559-45f5-44d9-b939-8a077ade8bb7)
![ec2-sg-2](https://github.com/murari-mura03/RaizeTech/assets/150114064/73e0bb7c-5e07-42ea-bfdb-4ff6943edf6c)

## インバウンドルールをマイIPへ変更後

![ec2-sg-ch](https://github.com/murari-mura03/RaizeTech/assets/150114064/290e4c6d-6a34-4c5e-931c-441474424f9c)

## RDS作成

- 標準作成を選択
- MySQL
- 無料利用枠
- パスワードの設定
- EC2コンピューティングリソースに接続しないを選択
- VPCを選択(データベース作成後に変更できないので注意)
- DBサブネットグループ
  - PrivateSubnetを選んで作成しておき選択する
- パブリックアクセスなし
- VPCセキュリティグループ 新規作成
- アベイラビリティゾーン EC2と同じに設定
- 自動バックアップを無効にする

  ![rds](https://github.com/murari-mura03/RaizeTech/assets/150114064/e5fdd398-4f7c-4ea4-b3d1-a3a2a9f8dbda)

![rds-subnet](https://github.com/murari-mura03/RaizeTech/assets/150114064/ac292cc2-4dfc-4c0e-9c0b-f1a2c2465962)

> [!WARNING]
> マスターパスワードは作成した時の[認証情報の詳細の表示]でしか確認できないので注意する。

## RDSセキュリティグループ

- インバウンドルールを変更しようとした場合`既存のIPv4CIDRルールに1つの参照先のグループ IDを指定することはできません。`という警告が出る。
  - 右側にある「削除」をクリックし、対象ルールを一度削除する。
  - 「ルール追加」をクリックし、新規ルールを追加することで設定をアップデートできる。

![rds-sg-2](https://github.com/murari-mura03/RaizeTech/assets/150114064/638a8ec8-ac8d-44cc-9caf-bd97c9aa6ab5)
![rds-sg](https://github.com/murari-mura03/RaizeTech/assets/150114064/1ee01af9-c426-4ee5-8dd0-80ea2d37906d)

## EC2でRDSに接続

![ec2-rds](https://github.com/murari-mura03/RaizeTech/assets/150114064/ce125166-83be-44fc-9376-604d6c6f3194)

## インバウンドルール変更後SSHクライアントで接続確認

![スクリーンショット 2023-11-21 223029](https://github.com/murari-mura03/RaizeTech/assets/150114064/f9d3e901-0c36-4824-96d2-bc237bf8bc21)

参考
- [【初心者向け】RDS for MySQLを構築しEC2からアクセスしてみる](https://dev.classmethod.jp/articles/sales-rds-ec2-session/)
- [既存の IPv4 CIDR ルールに 1 つの 参照先のグループ ID を指定することはできません。]( https://qiita.com/himorishuhei/items/7426cab6cd83c3d8e4e3)#Qiita 