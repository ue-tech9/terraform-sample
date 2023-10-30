# 必要なプロバイダとそのバージョンを定義
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"  // AWSプロバイダのソース
      version = "~> 5.0"          // バージョン指定
    }
  }
}

# AWSプロバイダの設定
provider aws {
  region = "ap-northeast-1"  // AWSリージョン（東京リージョン）
}

