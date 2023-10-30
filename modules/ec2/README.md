
#### ec2.tfファイル

| リソースタイプ                     | リソース名                    | 説明                                                                                                   |
|------------------------------------|--------------------------------|--------------------------------------------------------------------------------------------------------|
| aws_alb_target_group               | example                        | ALB（Application Load Balancer）のターゲットグループを作成します。                                        |
| aws_autoscaling_group              | user_server_asg                | ユーザ用サーバのAuto Scaling Groupを作成し、スケーリングとターゲットグループの関連付けを行います。  |
| aws_autoscaling_policy             | example                        | スケーリングポリシーを設定し、CPU利用率をトラッキングするターゲットトラッキングスケーリングを使用します。 |
| aws_autoscaling_attachment         | asg_attachment                 | Auto Scaling GroupとALBターゲットグループの関連付けを行います。                                      |
| aws_launch_template                | user_server_lt                 | EC2インスタンスの起動テンプレートを作成し、インスタンスの設定を指定します。                             |

#### variables.tfファイル

| 変数名                        | 説明                                               |
|-------------------------------|----------------------------------------------------|
| vpc_id                        | VPCのID                                            |
| subnets                       | サブネットのIDのリスト                            |
| availability_zones             | 使用可能なゾーンのリスト                          |
| ami_id                        | インスタンス用のAMI（Amazon Machine Image）のID    |
| key_name                      | インスタンスに関連付けるSSHキーの名前             |
| asg_name                      | Auto Scaling Groupの名前                          |
| min_size                      | Auto Scaling Groupの最小サイズ                    |
| max_size                      | Auto Scaling Groupの最大サイズ                    |
| protected_subnet_ids          | プライベートサブネットのIDのリスト                  |

#### output.tfファイル

| 出力名                        | 説明                                       |
|-------------------------------|--------------------------------------------|
| autoscaling_group_id           | Auto Scaling GroupのID                     |

