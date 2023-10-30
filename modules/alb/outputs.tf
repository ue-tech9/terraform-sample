# 出力変数の定義

# 作成したALBのARNを出力
output "alb_arn" {
  description = "作成したALBのARN"
  value       = aws_lb.this.arn
}

# 作成したターゲットグループのARNを出力
output "target_group_arn" {
  description = "作成したターゲットグループのARN"
  value       = aws_lb_target_group.this.arn
}


