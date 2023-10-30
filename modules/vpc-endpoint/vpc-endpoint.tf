# VPCエンドポイントリソースを作成
resource "aws_vpc_endpoint" "this" {
  vpc_id            = var.vpc_id        // VPCのID
  service_name      = var.service       // 接続先サービス名
  vpc_endpoint_type = var.endpoint_type // エンドポイントのタイプ（InterfaceまたはGateway）

  route_table_ids   = var.route_table_ids // 適用するルートテーブルのIDリスト

  // タグの設定
  tags = {
    Name = var.name // VPCエンドポイントの名前
  }
}


