# VPC (Virtual Private Cloud) モジュール
# AWS上にプライベートなネットワーク環境(VPC)を作成するためのモジュール
module "vpc" {
  source   = "../../modules/vpc"  # VPCを作成するTerraformモジュールの相対パス
  vpc_name = "sample-dev-vpc"      # 作成するVPCの名前
  vpc_cidr = "10.0.0.0/16"         # VPCのCIDRアドレスブロック
}

# サブネットモジュール
# 上で作成したVPC内で使用するサブネットを作成するモジュール
module "subnet" {
  source  = "../../modules/subnet"  # サブネットを作成するTerraformモジュールの相対パス
  vpc_id  = module.vpc.vpc_id       # 親となるVPCのID

  # 公開サブネットの設定
  # このサブネットはインターネットと通信可能です
  public_subnets = [
    {
      name = "sample-dev-public-subnet1a",  # サブネットの名前
      cidr = "10.0.0.0/24",                 # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1a"              # 使用するAWSの利用可能ゾーン
    },
    {
      name = "sample-dev-public-subnet1c",  # サブネットの名前
      cidr = "10.0.1.0/24",                 # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1c"              # 使用するAWSの利用可能ゾーン
    }
  ]

  # 保護されたサブネットの設定
  # このサブネットは内部通信専用です
  protected_subnets = [
    {
      name = "sample-dev-protected-subnet1a",  # サブネットの名前
      cidr = "10.0.10.0/24",                    # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1a"                  # 使用するAWSの利用可能ゾーン
    },
    {
      name = "sample-dev-protected-subnet1c",  # サブネットの名前
      cidr = "10.0.11.0/24",                    # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1c"                  # 使用するAWSの利用可能ゾーン
    }
  ]

  # データストア用サブネットの設定
  # このサブネットはデータストア（例：RDS）専用です
  datastore_subnets = [
    {
      name = "sample-dev-datastore-subnet1a",  # サブネットの名前
      cidr = "10.0.20.0/24",                    # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1a"                  # 使用するAWSの利用可能ゾーン
    },
    {
      name = "sample-dev-datastore-subnet1c",  # サブネットの名前
      cidr = "10.0.21.0/24",                    # サブネットのCIDRアドレスブロック
      az   = "ap-northeast-1c"                  # 使用するAWSの利用可能ゾーン
    }
  ]
}


# インターネットゲートウェイモジュール
# VPCにインターネット接続を提供するインターネットゲートウェイを作成
module "internet_gateway" {
  source = "../../modules/internet-gateway"  # インターネットゲートウェイを作成するTerraformモジュールの相対パス
  vpc_id = module.vpc.vpc_id                 # 親となるVPCのID
}

# NATゲートウェイ1aモジュール
# 1aゾーンにNATゲートウェイを作成
module "nat_gateway_1a" {
  source    = "../../modules/nat-gateway"    # NATゲートウェイを作成するTerraformモジュールの相対パス
  name      = "sample-dev-ngw1a"             # NATゲートウェイの名前
  subnet_id = module.subnet.public_subnet_ids[0]  # 1aに対応する公開サブネットのID
}

# NATゲートウェイ1cモジュール
# 1cゾーンにNATゲートウェイを作成
module "nat_gateway_1c" {
  source    = "../../modules/nat-gateway"    # NATゲートウェイを作成するTerraformモジュールの相対パス
  name      = "sample-dev-ngw1c"             # NATゲートウェイの名前
  subnet_id = module.subnet.public_subnet_ids[1]  # 1cに対応する公開サブネットのID
}

# ネットワークACLモジュール
# VPCにネットワークアクセス制御リスト（ACL）を作成
module "network_acl" {
  source = "../../modules/network-acl"  # ネットワークACLを作成するTerraformモジュールの相対パス
  vpc_id = module.vpc.vpc_id            # 親となるVPCのID
}

# ルートテーブルモジュール
# VPCにルートテーブルを作成し、インターネットゲートウェイへのルートを追加
module "route_table" {
  source      = "../../modules/route-table"      # ルートテーブルを作成するTerraformモジュールの相対パス
  vpc_id      = module.vpc.vpc_id                # 親となるVPCのID
  name        = "sample-dev-public-rtb"          # ルートテーブルの名前
  destination = "0.0.0.0/0"                      # どのIPアドレス範囲に適用するか（ここではすべて）
  target      = module.internet_gateway.internet_gateway_id  # インターネットゲートウェイのIDを指定
}
# VPCエンドポイントモジュール
# AWSの特定のサービス（この場合はS3）へのプライベート接続を提供するVPCエンドポイントを作成
module "vpc_endpoint" {
  source         = "../../modules/vpc-endpoint"  # VPCエンドポイントを作成するTerraformモジュールの相対パス
  vpc_id         = module.vpc.vpc_id             # 親となるVPCのID
  name           = "sample-dev-s3-gw-endpoint"   # VPCエンドポイントの名前
  service        = "com.amazonaws.ap-northeast-1.s3"  # 接続するAWSサービス（この場合はap-northeast-1リージョンのS3）
  endpoint_type  = "Gateway"                     # エンドポイントのタイプ（この場合はゲートウェイ）
  route_table_ids = [module.route_table.route_table_id]  # このエンドポイントを使用するルートテーブルのID
}


# sample-dev-public-rtbとpublicサブネットの関連付け（最初の定義を使用する場合はこの行を残す）
resource "aws_route_table_association" "public_rtb_association" {
  subnet_id      = module.subnet.public_subnet_ids[0] # publicサブネットのID
  route_table_id = module.route_table.route_table_id
}

# sample-dev-protected-rtb1aとprotectedサブネット1aの関連付け
resource "aws_route_table_association" "protected1a_rtb_association" {
  subnet_id      = module.subnet.protected_subnet_ids[0] # protectedサブネット1aのID
  route_table_id = module.route_table.route_table_id
}

# sample-dev-protected-rtb1cとprotectedサブネット1cの関連付け
resource "aws_route_table_association" "protected1c_rtb_association" {
  subnet_id      = module.subnet.protected_subnet_ids[1] # protectedサブネット1cのID
  route_table_id = module.route_table.route_table_id
}

# sample-dev-datastore-rtbとdatastoreサブネットの関連付け
resource "aws_route_table_association" "datastore_rtb_association" {
  subnet_id      = module.subnet.datastore_subnet_ids[0] # datastoreサブネットのID
  route_table_id = module.route_table.route_table_id
}

# sample-dev-public-subnet1cと対応するルートテーブルの関連付け
resource "aws_route_table_association" "public1c_rtb_association" {
  subnet_id      = module.subnet.public_subnet_ids[1]
  route_table_id = module.route_table.route_table_id
}

# sample-dev-datastore-subnet1cと対応するルートテーブルの関連付け
resource "aws_route_table_association" "datastore1c_rtb_association" {
  subnet_id      = module.subnet.datastore_subnet_ids[1]
  route_table_id = module.route_table.route_table_id
}

# ユーザ用ALBセキュリティグループ
module "user_alb_sg" {
  source = "../../modules/sg"
  name   = "sample-dev-alb-users-sg"
  vpc_id = module.vpc.vpc_id
  tags = {
    "Name"        = "sample-dev-alb-users-sg"
    "Environment" = "Development"
  }
}

# ユーザ用EC2セキュリティグループ
module "user_ec2_sg" {
  source = "../../modules/sg"
  name   = "sample-dev-users-sg"
  vpc_id = module.vpc.vpc_id
  tags = {
    "Name"        = "sample-dev-users-sg"
    "Environment" = "Development"
  }
}

# RDSセキュリティグループ
module "rds_sg" {
  source = "../../modules/sg"
  name   = "sample-dev-rds-sg"
  vpc_id = module.vpc.vpc_id
  tags = {
    "Name"        = "sample-dev-rds-sg"
    "Environment" = "Development"
  }
}

# 10桁のランダムな整数を生成するリソース定義
# この値は、var.some_variable が変更された場合にのみ再生成されます。
resource "random_integer" "rand" {
  min = 1000000000  # 10桁の最小値
  max = 9999999999  # 10桁の最大値
}

# ローカル変数を定義して、バケット名に使用する一意な識別子を生成
locals {
  unique_identifier = random_integer.rand.result
}

# S3バケットのモジュール定義
module "s3_buckets" {
  source = "../../modules/s3"

  # 画像保存用バケット名に一意な識別子を追加
  image_bucket_name = "sample-dev-images-s3-${local.unique_identifier}"
  
  # ALBログ保存用バケット名に一意な識別子を追加
  alb_log_bucket_name = "sample-dev-alb-log-s3-${local.unique_identifier}"
}

module "alb" {
  source = "../../modules/alb"
  vpc_id  = module.vpc.vpc_id   # 親となるVPCのID
  alb_name = "sample-dev-users-alb" # ロードバランサー名
  scheme = "internet-facing" # スキーム
  ip_address_type = "ipv4" # IPアドレスタイプ
  subnet_ids = [module.subnet.public_subnet_ids[0], module.subnet.public_subnet_ids[1]] # 1aと1cに対応する公開サブネットのID
  security_group_ids = [module.user_alb_sg.sg_id] # セキュリティグループ
}

# Auto Scaling Group の設定をするためのモジュールを呼び出します
module "auto_scaling_group" {
  source = "../../modules/ec2"  # モジュールのソースディレクトリ
  vpc_id  = module.vpc.vpc_id   # 親となるVPCのIDを設定
  
  ami_id  = "ami-0bba69335379e17f8"  # 使用するAmazon Machine ImageのID
  instance_type = "m5.large"  # EC2インスタンスのタイプ
  
  key_name = "your-key-name"  # キーペアの名前
  availability_zones = ["ap-northeast-1a", "ap-northeast-1c"]  # 利用するAZ（Availability Zones）

  asg_name = "my-asg"  # Auto Scaling Groupの名前
  min_size = 2  # 最小インスタンス数
  max_size = 10  # 最大インスタンス数
  
  # サブネットIDのリスト（プライベートサブネット）
  subnets = [module.subnet.protected_subnet_ids[0], module.subnet.protected_subnet_ids[1]]
  
  # スケールイン保護を有効にするサブネットのID
  protected_subnet_ids = module.subnet.protected_subnet_ids
}

# Aurora モジュールの設定
module "aurora" {
  source = "../../modules/rds"  # RDS用の共通モジュールを指定

  vpc_id = module.vpc.vpc_id  # 親となるVPCのIDを指定
  subnet_ids = [module.subnet.datastore_subnet_ids[0], module.subnet.datastore_subnet_ids[1]]  # 使用するサブネットのIDを指定
  subnet_group_name = "sample-dev-dbsg"  # DB用のサブネットグループ名
  security_group = "sample-dev-rds-sg"  # RDSに適用するセキュリティグループ名
  aurora_cluster_name = "sample-dev-cluster"  # Auroraクラスタの名前
  aurora_instance_name = "sample-dev-instance"  # Auroraインスタンスの名前
  master_username = "yourMasterUsername"  # マスターユーザー名(環境にあわせて変更してください。)
  master_password = "Password123!"  # マスターパスワード（環境にあわせて変更してください。）
  instance_class = "db.r6g.xlarge"  # インスタンスタイプ（変更後）
}
