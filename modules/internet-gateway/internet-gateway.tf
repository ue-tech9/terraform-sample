# インターネットゲートウェイを作成
resource "aws_internet_gateway" "this" {
  vpc_id = var.vpc_id  # アタッチするVPCのID

  tags = {
    Name = var.name  # インターネットゲートウェイの名前
  }
}
