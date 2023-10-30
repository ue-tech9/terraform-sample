
main.tfの説明
| モジュール/リソース名               | 説明                                                                                                               |
|-------------------------------------|--------------------------------------------------------------------------------------------------------------------|
| `module "vpc"`                      | AWS上にプライベートなネットワーク環境（VPC）を作成するモジュール。                                                |
| `module "subnet"`                   | 作成したVPC内で使用するサブネットを作成。公開、保護、データストア用のサブネットをそれぞれ設定可能。                 |
| `module "internet_gateway"`         | VPCにインターネット接続を提供するインターネットゲートウェイを作成。                                               |
| `module "nat_gateway_1a"`           | 1aゾーンにNATゲートウェイを作成。公開サブネット内で使用。                                                         |
| `module "nat_gateway_1c"`           | 1cゾーンにNATゲートウェイを作成。公開サブネット内で使用。                                                         |
| `module "network_acl"`              | VPCにネットワークアクセス制御リスト（ACL）を作成。                                                                |
| `module "route_table"`              | VPC内で使用するルートテーブルを作成し、インターネットゲートウェイへのルートを追加。                                 |
| `module "vpc_endpoint"`             | AWS S3などの特定のサービスへのプライベート接続を提供するVPCエンドポイントを作成。                                  |
| `resource "aws_route_table_association"` | サブネットとルートテーブルの関連付け。公開、保護、データストア用の各サブネットに適用。 |
| `module "user_alb_sg"`              | ユーザ用のApplication Load Balancer（ALB）用のセキュリティグループを作成。                                         |
| `module "user_ec2_sg"`              | ユーザ用のEC2インスタンス用のセキュリティグループを作成。                                                         |
| `module "rds_sg"`                   | RDS用のセキュリティグループを作成。                                                                               |
| `random_integer.rand`   | 10桁のランダムな整数を生成します。この値は `var.some_variable` が変更された場合にのみ再生成されます。  |
| `unique_identifier`    | `random_integer.rand.result` から得られたランダムな整数を保持します。この一意な識別子は後でS3バケット名に使用されます。      |
| `s3_buckets`            | S3バケットを作成するためのモジュールを呼び出します。                                           |
| `image_bucket_name`     | 画像保存用のS3バケット名に一意な識別子（`local.unique_identifier`）を追加します。                      |
| `alb_log_bucket_name`   | ALBログ保存用のS3バケット名に一意な識別子（`local.unique_identifier`）を追加します。                    |
| `module "alb"`                            | AWS上のApplication Load Balancer（ALB）を作成・管理するTerraformモジュール。                    |
| `source = "../../modules/alb"`            | `module "alb"`のソースコードが存在するディレクトリへの相対パス。                               |
| `vpc_id = module.vpc.vpc_id`              | ALBを作成するVPC（Virtual Private Cloud）のID。                                                |
| `alb_name = "sample-dev-users-alb"`       | 作成するALBの名前。                                                                            |
| `scheme = "internet-facing"`              | ALBが使用するスキーム。一般にインターネットに公開される場合は`internet-facing`を指定。         |
| `ip_address_type = "ipv4"`                | ALBが使用するIPアドレスのタイプ。通常は`ipv4`。                                                |
| `subnet_ids = [module.subnet.public_subnet_ids[0], module.subnet.public_subnet_ids[1]]` | ALBに割り当てるサブネットのID。通常、公開サブネットが指定されます。      |
| `security_group_ids = [module.user_alb_sg.sg_id]` | ALBに割り当てるセキュリティグループのID。通常、ALB用に作成したセキュリティグループが使用されます。 |
| `source`                                  | `module "auto_scaling_group"` のソースコードが存在するディレクトリへの相対パス。 |
| `vpc_id`                                | 親となる VPC の ID。 |
| `ami_id`                                | 起動する EC2 インスタンスの AMI ID。 |
| `key_name`                                | SSH 接続に使用するキーペアの ID。 |
| `availability_zones`                                | EC2 インスタンスを起動する AZ のリスト。 |
| `asg_name`                                | Auto Scaling グループの名前。 |
| `min_size`                                | Auto Scaling グループの最小インスタンス数。 |
| `max_size`                                | Auto Scaling グループの最大インスタンス数。 |
| `subnets`                                | Auto Scaling グループに使用するサブネットのリスト。 |
| `protected_subnet_ids`                                | 保護されたサブネットの ID のリスト。 |
| `module "aurora" {...}`                                | Aurora用のTerraformモジュールを使用する宣言です。                        |
| `source = "../../modules/rds"`                         | RDS用の共通モジュールのパスを指定します。                                 |
| `vpc_id = module.vpc.vpc_id`                           | 親となるVPCのIDを指定します。                                              |
| `subnet_ids = [module.subnet.datastore_subnet_ids[0], ...]` | 使用するサブネットのIDを指定します。                                       |
| `subnet_group_name = "sample-dev-dbsg"`                | DB用のサブネットグループ名を指定します。                                   |
| `security_group = "sample-dev-rds-sg"`                 | RDSに適用するセキュリティグループ名を指定します。                           |
| `aurora_cluster_name = "sample-dev-cluster"`           | Auroraクラスタの名前を指定します。                                         |
| `aurora_instance_name = "sample-dev-instance"`         | Auroraインスタンスの名前を指定します。                                      |
| `master_username = "yourMasterUsername"`               | マスターユーザー名を指定します。環境に合わせて変更する必要があります。        |
| `master_password = "Password123!"`                     | マスターパスワードを指定します。環境に合わせて変更する必要があります。         |
| `instance_class = "db.r5.large"`                       | 使用するDBインスタンスのクラス（タイプ）を指定します。                        |

