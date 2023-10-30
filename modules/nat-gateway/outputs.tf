# NATゲートウェイのIDを出力
output "nat_gateway_id" {
  value = aws_nat_gateway.this.id  // 作成したNATゲートウェイのID
}

