# VPCのIDを指定
variable "vpc_id" {
  description = "The VPC ID."
}

# VPCエンドポイントの名前を指定
variable "name" {
  description = "The name of the VPC endpoint."
}

# 接続先サービス名を指定
variable "service" {
  description = "The service name."
}

# エンドポイントのタイプを指定（InterfaceまたはGateway）
variable "endpoint_type" {
  description = "The VPC endpoint type."
}

# 適用するルートテーブルのIDリストを指定
variable "route_table_ids" {
  description = "The route table IDs."
  type        = list(string)
}

