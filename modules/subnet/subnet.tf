# Public サブネットを作成
resource "aws_subnet" "public" {
  count = length(var.public_subnets)  # 公開サブネットの数だけリソースを作成
  vpc_id                  = var.vpc_id  # VPC ID
  cidr_block              = var.public_subnets[count.index].cidr  # CIDR ブロック
  availability_zone       = var.public_subnets[count.index].az  # 利用可能ゾーン
  map_public_ip_on_launch = true  # EC2 インスタンスにパブリック IP を自動割り当て

  tags = {
    Name = var.public_subnets[count.index].name  # タグ名
  }
}

# Protected サブネットを作成
resource "aws_subnet" "protected" {
  count = length(var.protected_subnets)  # 保護されたサブネットの数だけリソースを作成
  vpc_id                  = var.vpc_id  # VPC ID
  cidr_block              = var.protected_subnets[count.index].cidr  # CIDR ブロック
  availability_zone       = var.protected_subnets[count.index].az  # 利用可能ゾーン

  tags = {
    Name = var.protected_subnets[count.index].name  # タグ名
  }
}

# Datastore サブネットを作成
resource "aws_subnet" "datastore" {
  count = length(var.datastore_subnets)  # データストアサブネットの数だけリソースを作成
  vpc_id                  = var.vpc_id  # VPC ID
  cidr_block              = var.datastore_subnets[count.index].cidr  # CIDR ブロック
  availability_zone       = var.datastore_subnets[count.index].az  # 利用可能ゾーン

  tags = {
    Name = var.datastore_subnets[count.index].name  # タグ名
  }
}
