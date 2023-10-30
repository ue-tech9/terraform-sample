# AWS セキュリティグループリソースの定義
resource "aws_security_group" "this" {
  name        = var.name         # セキュリティグループの名前
  description = var.description  # セキュリティグループの説明
  vpc_id      = var.vpc_id       # 関連付けるVPCのID

  # インバウンドルールの定義
  # dynamicブロックを使用して、複数のインバウンドルールを動的に生成
  dynamic "ingress" {
    for_each = var.ingress_rules  # 入力されたインバウンドルールのリストを反復処理
    content {
      from_port   = ingress.value["from_port"]   # 開始ポート番号
      to_port     = ingress.value["to_port"]     # 終了ポート番号
      protocol    = ingress.value["protocol"]    # プロトコル (TCP/UDP/ICMP)
      cidr_blocks = ingress.value["cidr_blocks"] # 許可するIP範囲
    }
  }

  # アウトバウンドルールの定義
  # dynamicブロックを使用して、複数のアウトバウンドルールを動的に生成
  dynamic "egress" {
    for_each = var.egress_rules  # 入力されたアウトバウンドルールのリストを反復処理
    content {
      from_port   = egress.value["from_port"]   # 開始ポート番号
      to_port     = egress.value["to_port"]     # 終了ポート番号
      protocol    = egress.value["protocol"]    # プロトコル (TCP/UDP/ICMP)
      cidr_blocks = egress.value["cidr_blocks"] # 許可するIP範囲
    }
  }
}
