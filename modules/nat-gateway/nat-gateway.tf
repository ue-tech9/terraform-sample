# NATゲートウェイリソースを作成
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat[0].id  // 最初のEIP（Elastic IP）を使用
  subnet_id     = var.subnet_id  // NATゲートウェイに関連付けるサブネットのID

  tags = {
    Name = var.name  // NATゲートウェイの名前
  }
}

# Elastic IPリソースを作成
resource "aws_eip" "nat" {
  count  = 1  // 作成するEIPの数
  domain = "vpc"  // VPC内でEIPを使用（vpc = trueの代わりに）
}

