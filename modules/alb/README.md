
| ファイル名      | セクション                    | 説明                                                                                                                         |
|-----------------|------------------------------|------------------------------------------------------------------------------------------------------------------------------|
| alb.tf          | resource "aws_lb" "this"     | Application Load Balancer(ALB)の設定。セキュリティグループ、サブネット、その他のオプション（HTTP/2、タイムアウトなど）を定義。 |
|                 | resource "aws_lb_target_group" "this" | ターゲットグループの設定。ヘルスチェック、プロトコル、ポートなどを定義。                                                   |
| variables.tf    | variable "alb_name"          | ALBの名前を定義する変数。                                                                                                    |
|                 | variable "scheme"            | ALBのスキーム（`internet-facing`または`internal`）を定義する変数。                                                           |
|                 | variable "ip_address_type"   | ALBのIPアドレスタイプ（ipv4）を定義する変数。                                                                                |
|                 | variable "vpc_id"            | ALBを作成するVPCのIDを定義する変数。                                                                                         |
|                 | variable "subnet_ids"        | ALBに使用するサブネットIDのリストを定義する変数。                                                                             |
|                 | variable "security_group_ids"| ALBに割り当てるセキュリティグループIDのリストを定義する変数。                                                                |
|                 | variable "certificate_arn"   | SSL/TLS証明書のARNを定義する変数。デフォルトは`null`。                                                                        |
| output.tf       | output "alb_arn"             | 作成したALBのARNを出力する。                                                                                                  |
|                 | output "target_group_arn"    | 作成したターゲットグループのARNを出力する。                                                                                   |

