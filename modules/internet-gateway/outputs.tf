# インターネットゲートウェイIDを出力
output "internet_gateway_id" {
  value = aws_internet_gateway.this.id  # 作成したインターネットゲートウェイのID
}
