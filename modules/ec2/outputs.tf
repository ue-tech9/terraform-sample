# 出力定義
# 出力変数の定義

# ASG IDを出力
output "autoscaling_group_id" {
  value       = aws_autoscaling_group.user_server_asg.id  # ASG ID
  description = "Auto Scaling GroupのID"  # 説明
}

