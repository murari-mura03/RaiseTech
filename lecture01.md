# 第1回講義課題

## AWSアカウント作成

```Markdown
 1. AWSアカウントを作成し、rootユーザーをMFAで保護する。
 2. BilingをIAMユーザーで閲覧できるように設定する。
 3. AdministratorAccess権限のIAMユーザーを作成し、こちらもMFAで保護する。
```

## Cloud9作成とHelloWorldの実行

```Markdown
 1. Cloud9をAmazon Linux2で作成。
 2. Rubyで"HelloWorld"が出せるようにコードを記載し実行する。  
 ```

<br>

# 課題内容

## AWSアカウントの作成

1. [AWS公式サイト](https://aws.amazon.com/jp/register-flow/)を参考にアカウントの作成を行う。
2. rootユーザーが作成できたらコンソール画面よりセキュリティ認証情報を選択。
3. MFAデバイスの割り当てをクリックし、｢仮想MFAデバイス｣を選択。
4. 認証アプリで追加を選択し、QRコードを使い設定を行う。
5. BilingをIAMユーザーで閲覧できるように設定する。  
    - rootユーザーのアカウントタブで｢IAMユーザーおよびロールによる請求情報へのアクセス｣のアクティブ化にチェックを入れる。  
    - この操作でBillingに関するアクセス権があるポリシーがアタッチされているIAMユーザーで請求情報が見られるようになる。
6. IAMダッシュボードに移動し、ユーザータブへ移動。
7. ユーザーの詳細を入力。｢IAMユーザーを作成｣を選択する。
8. 許可の設定でAdministratorAccessを選択し、今回の場合は直接アタッチする。
    - ベストプラクティスとしてはグループにポリシーをアタッチすることを推奨しているので注意。
    - AdministratorAccessはAWSサービスおよびリソースへのフルアクセスを提供するAWSマネージドポリシー。あらゆるリソースが利用でき、IAMアカウントの新規発行や削除の権限やパスワードのリセット権限も所持している状態となる。([公式リファレンスガイド](https://docs.aws.amazon.com/ja_jp/aws-managed-policy/latest/reference/AdministratorAccess.html))
