### internet-gateway.tfファイル

| 項目                          | 説明                                                                                      |
|-------------------------------|-------------------------------------------------------------------------------------------|
| `resource "aws_internet_gateway"` | AWS Internet Gatewayを定義するTerraformリソースです。                                            |
| `vpc_id`                       | Internet Gatewayを作成するVPCのIDを指定します。このIDは`variables.tf`で定義されています。             |
| `tags`                         | AWSリソースに付けるタグを定義します。この例では`Name`タグが設定されています。                           |

### variables.tfファイル

| 項目                         | 説明                                                                                |
|------------------------------|-------------------------------------------------------------------------------------|
| `variable "vpc_id"`          | Internet Gatewayが作成されるVPCのIDを指定します。                                                               |
| `variable "name"`            | Internet Gatewayに設定する名前タグを指定します。この名前はオプションでデフォルト値`"sample-dev-igw"`があります。 |

### output.tfファイル

| 項目                           | 説明                                                                               |
|--------------------------------|------------------------------------------------------------------------------------|
| `output "internet_gateway_id"` | 生成されたInternet GatewayのIDを出力します。このIDは他のTerraformコードやモジュールで使用できます。          |
