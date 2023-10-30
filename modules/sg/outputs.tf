# 出力（output）ブロックでセキュリティグループのIDを出力する設定を行います。
output "security_group_id" {
  # aws_security_group.this.id は、"this" と名付けられた aws_security_group リソースのIDを取得します。
  value = aws_security_group.this.id
}

output "sg_id" {
  description = "セキュリティグループID"
  value       = aws_security_group.this.id
}
