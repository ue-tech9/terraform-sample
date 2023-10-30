output "aurora_cluster_id" {
  value       = aws_rds_cluster.this.id
  description = "Aurora クラスタのID"
}

output "aurora_instance_id" {
  value       = aws_rds_cluster_instance.this.id
  description = "Aurora インスタンスのID"
}

output "aurora_endpoint" {
  value       = aws_rds_cluster.this.endpoint
  description = "Aurora クラスタのエンドポイント"
}
