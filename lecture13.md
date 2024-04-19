# 第13回講義課題

```text
CircleCI のサンプルに ServerSpec や Ansible の処理を追加し結果を報告
```

## webアプリケーションのデプロイ環境を自動構築する

### 構成図

![Alt text](images13/1301.jpg)

### 作成したコード

https://github.com/murari-mura03/lecture13

- 実際のコード、実行結果の証跡など細かい設定はこちらのリポジトリへ記載しています

### 使用ツール

```sh
1.CircleCI
- Cloudformation、Ansible、serverspecの実行

2.Cloudformation

- 第10回講義課題で作成したテンプレートを使用
- VPC、EC2、ELB、RDS、S3、IAMを作成

3.Ansible

- EC2へサンプルアプリケーション用の設定作業を行う
- MySQL、Ruby、Nginx、puma

4.serverspec

ミドルウェア起動確認、アプリケーションレスポンス確認
```

- 以上を使用し自動化を行った
