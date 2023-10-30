# 作成したVPCエンドポイントのIDを出力
output "vpc_endpoint_id" {
  value = aws_vpc_endpoint.this.id // 作成したVPCエンドポイントのID
}

