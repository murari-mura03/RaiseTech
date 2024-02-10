## 第10回講義課題
- CloudFormation を利用して、現在までに作った環境をコード化し、コード化ができたら実行してみて、環境が自動で作られることを確認を行う。

#### CLoudFormationでコード化
- ネットワーク、セキュリティ、アプリケーションのレイヤーにそれぞれ分けて作成。

|                                   |                                                                                                        | 
| :-------------------------------: | ------------------------------------------------------------------------------------------------------ | 
| Network_Layer             | VPC<br>PublicSubnet<br>PrivateSubnet<br>InternetGateWay<br>RouteTable                                  | 
| Security_Layer                | EC2SecurityGroup<br>RDSSecurityGroup<br>ALBSecurityGroup                                               | 
| Application_Layer | EC2<br>RDS<br>Secrets Managet<br>RDSSubnetGroup<br>ALB<br>ALBTargetGroup<br>ALBLisner<br>S3<br>IAMRole | 

#### 実際のテンプレート
[CloudFormationTemplate](https://github.com/murari-mura03/RaizeTech/tree/b251fcb773272abd6ce57e084ac8793990aa4f55/CloudFormation "Template")

- リソース作成確認
![CloudFormation](images10/CloudFormation.png)

#### VPC
![VPC](<images10/VPC Console .png>)
- PubulicSubnet、privateSubnet各2つ作成

#### SecurityGroup
![SecurityGroup](images10/SecurityGroups.png)
- EC2、RDS、ALB用に3つ作成

#### EC2
![EC2](images10/EC2.png)
#### RDS
![RDS](images10/RDS.png)
- パスワード保護のためSecretsManagerを使用。

#### EC2からRDSへSSH接続確認
![EC2-RDS](images10/connection.png)

#### S3
![S3](images10/s3.png)