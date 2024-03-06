# 第10回講義課題

```text
- CloudFormationを利用して現在までに作った環境をコード化し実行する。
- 環境が自動で作られることを確認を行う。
```

## CLoudFormationで環境をコード化

- ネットワーク、セキュリティ、アプリケーションのレイヤーにそれぞれ分けて作成。

|スタック|リソース|
| :---| :--- |
|Network_Layer| ● VPC<br>● PublicSubnet<br> ● PrivateSubnet<br> ● InternetGateWay<br> ● RouteTable|
|Security_Layer|● EC2SecurityGroup<br>● RDSSecurityGroup<br>● ALBSecurityGroup<br>● Secrets Managet<br>● IAMRole|
|Application_Layer|● EC2<br>● RDS<br>● Secrets Managet<br>● RDSSubnetGroup<br>● ALB<br>● ALBTargetGroup<br>● ALBLisner<br>● S3<br>|

## 実際のテンプレート

[CloudFormationTemplate](https://github.com/murari-mura03/RaizeTech/tree/127ffb4365d24aed3a92f3a222d0fe61851e8ff0/cloudformation)

## リソース作成確認

![CloudFormation](images10/CloudFormation.png)

## VPC

![VPC](<images10/VPC Console .png>)

- PubulicSubnet、privateSubnet各2つ作成

## SecurityGroup

![SecurityGroup](images10/SecurityGroups.png)

- EC2、RDS、ALB用に3つ作成

## EC2

![EC2](images10/EC2.png)

## RDS

![RDS](images10/RDS.png)

- パスワード保護のためSecretsManagerを使用。

## EC2からRDSへSSH接続確認

![EC2-RDS](images10/connection.png)

## S3

![S3](images10/s3.png)
