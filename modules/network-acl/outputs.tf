# Network ACL IDの出力
output "network_acl_id" {
  value       = aws_network_acl.example.id  // 作成したNetwork ACLのID
  description = "The ID of the created Network ACL."  // 説明
}


