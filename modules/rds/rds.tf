# Auroraクラスタ用のパラメータグループを作成
resource "aws_rds_cluster_parameter_group" "aurora_cluster_parameter_group" {
  name        = "sample-dev-pg-auroracluster"  # パラメータグループの名前
  family      = "aurora-mysql8.0"  # パラメータグループのファミリ
  description = "Custom parameter group for Aurora cluster"  # 説明

  # タイムゾーンを設定
  parameter {
    name  = "time_zone"
    value = "Asia/Tokyo"
  }

  # タグを設定
  tags = {
    Name = "sample-dev-pg-auroracluster"
  }
}

# Auroraインスタンス用のパラメータグループを作成
resource "aws_db_parameter_group" "aurora_instance_parameter_group" {
  name        = "sample-dev-pg-aurorainstance"  # パラメータグループの名前
  family      = "aurora-mysql8.0"  # パラメータグループのファミリ
  description = "Custom parameter group for Aurora instance"  # 説明
  
  # タグを設定
  tags = {
    Name = "sample-dev-pg-aurorainstance"
  }
}

# DB用のサブネットグループを作成
resource "aws_db_subnet_group" "this" {
  name       = "sample-dev-dbsg"  # サブネットグループの名前
  subnet_ids = var.subnet_ids  # サブネットID（変数から取得）

  # タグを設定
  tags = {
    Name = "sample-dev-dbsg"
  }
}

# Auroraクラスタを作成
resource "aws_rds_cluster" "this" {
  cluster_identifier  = var.aurora_cluster_name  # クラスタの識別子
  engine              = "aurora-mysql"  # 使用するエンジン
  engine_version      = "8.0.mysql_aurora.3.01.0"  # エンジンのバージョン
  master_username     = var.master_username  # マスターユーザー名
  master_password     = var.master_password  # マスターパスワード
  db_subnet_group_name = var.subnet_group_name  # サブネットグループ名
  skip_final_snapshot = true  # 最終スナップショットをスキップ
  depends_on = [aws_db_subnet_group.this]  # サブネットグループの作成が先
}

# Auroraインスタンスを作成
resource "aws_rds_cluster_instance" "this" {
  identifier         = var.aurora_instance_name  # インスタンスの識別子
  cluster_identifier = aws_rds_cluster.this.id  # 所属するクラスタのID
  instance_class     = var.instance_class  # インスタンスのタイプ
  engine             = "aurora-mysql"  # 使用するエンジン
}
