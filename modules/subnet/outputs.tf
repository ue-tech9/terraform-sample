# PublicサブネットIDを出力
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

# ProtectedサブネットIDを出力
output "protected_subnet_ids" {
  value = aws_subnet.protected[*].id
}

# DatastoreサブネットIDを出力
output "datastore_subnet_ids" {
  value = aws_subnet.datastore[*].id
}

