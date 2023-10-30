# ALB用のターゲットグループを作成
resource "aws_alb_target_group" "example" {
  name     = "example-targetgroup"  # ターゲットグループ名
  port     = 80  # ポート番号
  protocol = "HTTP"  # プロトコル
  vpc_id   = var.vpc_id  # VPC ID
}

# Auto Scaling Group (ASG) の設定
resource "aws_autoscaling_group" "user_server_asg" {
  name                 = "sample-dev-users-asg"  # ASG名
  launch_template {
    id      = aws_launch_template.user_server_lt.id  # ローンチテンプレートID
    version = "$Latest"  # ローンチテンプレートのバージョン
  }
  vpc_zone_identifier  = var.protected_subnet_ids  # サブネットID
  desired_capacity     = 2  # 望ましいインスタンス数
  min_size             = 2  # 最小インスタンス数
  max_size             = 4  # 最大インスタンス数
  target_group_arns    = [aws_alb_target_group.example.arn]  # ターゲットグループ
  protect_from_scale_in = true  # スケールイン保護を有効にする

  # タグ設定
  tag {
    key                 = "Name"
    value               = "sample-dev-users-asg"
    propagate_at_launch = true
  }
}

# ターゲットトラッキングスケーリングポリシー
resource "aws_autoscaling_policy" "example" {
  name                   = "example-policy"  # ポリシー名
  autoscaling_group_name = aws_autoscaling_group.user_server_asg.name  # ASG名
  policy_type            = "TargetTrackingScaling"  # ポリシーのタイプ

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"  # CPU使用率をトラッキング
    }

    target_value = 50.0  # 目標値
  }
}

# ターゲットグループとASGを関連付ける
resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.user_server_asg.name  # ASG名
  lb_target_group_arn    = aws_alb_target_group.example.arn  # ターゲットグループARN
}

# ローンチテンプレートの定義
resource "aws_launch_template" "user_server_lt" {
  name          = "sample-dev-users-template"  # テンプレート名
  instance_type = var.instance_type  # インスタンスタイプ
  image_id      = var.ami_id  # AMI ID
  key_name      = ""  # キーペアなし

  # タグ設定
  tags = {
    "Name" = "sample-dev-users-template"
    "Environment" = "Dev"
  }
}
