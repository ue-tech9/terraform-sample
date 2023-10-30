terraform {
  // バックエンドの設定。この例ではAWS S3をバックエンドとして使用。
  backend "s3" {
    bucket = "your-bucket-name-terraform"  // S3バケットの名前  自分の環境にあわせて名前をつけてください
    region = "ap-northeast-1"                   // AWSリージョン（この例では東京）
    key    = "dev/sample/terraform.tfstate/terraform.tfstate"  // S3内でのTerraformステートファイルのパス  自分の環境にあわせて名前をつけてください
  }
}
