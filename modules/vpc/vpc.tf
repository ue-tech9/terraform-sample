# AWS VPC（Virtual Private Cloud）リソースを定義
resource "aws_vpc" "sample_dev_vpc" {
  # VPCのCIDR（Classless Inter-Domain Routing）ブロックを設定
  cidr_block = var.vpc_cidr
  
  # VPC内でのEC2インスタンスのテナンシー（共有または専用）を設定
  instance_tenancy = var.tenancy
  
  # VPC内でのDNSサポートを有効にする
  enable_dns_support = true
  
  # VPC内でのDNSホスト名を有効にするかどうかを設定
  enable_dns_hostnames = var.enable_dns_hostnames
  
  # IPv6 CIDRブロックの自動割り当てを有効にするかどうかを設定
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  # AWSリソースにタグを割り当てる
  tags = {
    Name = var.vpc_name  # VPCの名前をタグに割り当て
  }
}


