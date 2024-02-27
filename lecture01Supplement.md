# 第1回講義補足事項

## そもそもAWSとは？

- AWSとはAmazon Web Servicesの略で、Amazonが提供しているクラウドコンピューティングサービスの総称。
- 世界中にサービス拠点(リージョン)を持ち、利用したい人はアカウントを作成するだけで、AWS が提供する 170 以上のサービス、たとえばサーバーやデータベースの機能を%Webブラウザだけですぐに利用が可能になります%{red}。

## 従来の物理サーバーとの違いとは

- クラウドコンピューティングサービスが登場する前まで、サーバーを利用する必要があれば自社の建物の中などにサーバー機器を設置して「オンプレミス」で運用するのが一般的でした。
- クラウドコンピューティングでは、「サーバー機器を購入する」「管理する」「スペースを確保する」「納期の間、待つ」といった必要がなくなります。

参考  

- [クラウド・AWSの情報メディア SKYARCHのITあんちょこ-AWSとは？ 初心者にもわかりやすく解説](https://www.skyarch.net/column/whataws01/)
- [AWSの基本･仕組み･重要用語が全部わかる教科書](https://www.amazon.co.jp/AWS%E3%81%AE%E5%9F%BA%E6%9C%AC%E3%83%BB%E4%BB%95%E7%B5%84%E3%81%BF%E3%83%BB%E9%87%8D%E8%A6%81%E7%94%A8%E8%AA%9E%E3%81%8C%E5%85%A8%E9%83%A8%E3%82%8F%E3%81%8B%E3%82%8B%E6%95%99%E7%A7%91%E6%9B%B8-%E8%A6%8B%E3%82%8B%E3%81%A0%E3%81%91%E5%9B%B3%E8%A7%A3-%E5%B7%9D%E7%95%91%E5%85%89%E5%B9%B3/dp/4815607850)

## rootユーザーとIAMユーザー

### rootユーザーとは？

- AWSのrootユーザーとは、AWSアカウント作成時に設定したメールアドレスとパスワードでログインできるユーザーのことです。
- このルートユーザーは、すべてのリソースに対して**無制限なアクセスが可能**なので、もし認証情報(メールアドレスとパスワード)が悪意のある第三者に漏洩しアカウントへの侵入を許した場合、非常に危険です。
- そのため、公式ユーザーガイドのベストプラクティスにもこう書かれています。

>[AWSアカウントのルートユーザーのベストプラクティス](https://docs.aws.amazon.com/ja_jp/IAM/latest/UserGuide/root-user-best-practices.html)  
>ルートユーザーの認証情報が必要なタスクがある場合を除き、AWS アカウントのルートユーザーにはアクセスしないことを強くお勧めします。  

### IAMユーザー

- rootユーザーで作業することが好ましくないので、IAMユーザーを作成し権限を付与して使用します。
- IAMユーザーはAWSアカウント内で作成できるユーザーで、紐づけられたIAMポリシー(今回はAdministratorAccess)によって操作できる内容が変化します。

> [!NOTE]
> - **IAMポリシー**を様々なリソースにアタッチして利用する。
> - IAMユーザーにIAMポリシーを直接アタッチすることは推奨されていない。
> - IAM（Identity and Access Management）の主要サービスはSAAで問われることも多く把握しておく。

参考

- [なぜAWSのrootユーザの利用が危険なのか？〜アカウント作成後の運用方法についてまとめてみた〜](https://dev.classmethod.jp/articles/rootuser-risk/)
- [IAMによるAWS権限管理 – プロジェクトメンバーへの権限付与方針に潜む闇](https://dev.classmethod.jp/articles/iam-policy-for-project-members/)
- [【AWS IAM】IAMユーザー、IAMグループ、IAMロール、IAMポリシーの違いを整理](https://uniuni-diary.com/aws-iam/)
- [AWS IAM の概念をざっくり理解する - サーバーワークスエンジニアブログ](https://blog.serverworks.co.jp/re-getting-started-iam)

## Cloud9

- Cloud9では**開発に必要なソフトウェアがほとんど最初から入っている**ため、ローカル開発環境の構築が必要なく、どのパソコンからでも同じ環境下で開発を進めることができます。

> [!WARNING]
> - Cloud9自体は無料のサービスだが、実態はEC2インスタンス(独自のサーバーも可)なので実際に使用した分に対しては料金が発生する。
> - Cloud9ではインスタンスが動いていることを意識しなくていいためつい放置してしまいがちだが、不要な課金を防ぐためにも自動停止時間を設定し、使用後は削除しておく。

参考

- [AWS Cloud9 のすゝめ](https://qiita.com/hatahatahata/items/66c0a186b6bfe2f9ef7f)
- [AWS Cloud9を導入して使い方を学ぼう](https://pikawaka.com/curriculums/programming-introduction/aws-cloud9)
- [AWS Cloud9 料金](https://aws.amazon.com/jp/cloud9/pricing/)