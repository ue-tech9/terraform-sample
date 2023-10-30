# ALB(Application Load Balancer)のリソースを作成
resource "aws_lb" "this" {
  name               = var.alb_name  # ロードバランサーの名前を設定
  internal           = false  # 内部ロードバランサーかどうか
  load_balancer_type = "application"  # ロードバランサーのタイプ
  security_groups    = var.security_group_ids  # セキュリティグループのID
  subnets            = var.subnet_ids  # サブネットのID
  enable_deletion_protection = false  # 削除保護を無効化
  enable_http2       = true  # HTTP/2を有効化
  idle_timeout       = 60  # アイドルタイムアウト時間
}

# ターゲットグループのリソースを作成
resource "aws_lb_target_group" "this" {
  name     = "sample-dev-users-tg"  # ターゲットグループの名前
  port     = 80  # ポート番号
  protocol = "HTTP"  # プロトコル
  vpc_id   = var.vpc_id  # VPCのID

  # ヘルスチェック設定
  health_check {
    enabled             = true  # ヘルスチェックを有効化
    path                = "/"  # ヘルスチェックのパス
    protocol            = "HTTP"  # ヘルスチェックのプロトコル
    healthy_threshold   = 5  # ヘルシーと判定するためのしきい値
    unhealthy_threshold = 2  # アンヘルシーと判定するためのしきい値
    timeout             = 5  # タイムアウト時間
    interval            = 6  # ヘルスチェックの間隔
    matcher             = "200"  # ヘルスチェックのマッチャー
  }
}

