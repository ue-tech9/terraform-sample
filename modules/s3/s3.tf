# 画像保存用バケットの設定
# アクセス制御はプライベートとしています
resource "aws_s3_bucket" "image_bucket" {
  bucket = var.image_bucket_name
}

# 画像保存用バケットにバージョニングを有効化
resource "aws_s3_bucket_versioning" "image_bucket_versioning" {
  bucket = aws_s3_bucket.image_bucket.id

  versioning_configuration {
    status = "Enabled"  # バージョニングを有効にする
  }
}

# ALBログ保存用バケットの設定
# アクセス制御はプライベートとしています
resource "aws_s3_bucket" "alb_log_bucket" {
  bucket = var.alb_log_bucket_name
}

# ALBログ保存用バケットに対するライフサイクル設定
# 365日後にオブジェクトを削除するように設定
resource "aws_s3_bucket_lifecycle_configuration" "alb_log_bucket_lifecycle" {
  bucket = aws_s3_bucket.alb_log_bucket.id

  rule {
    id      = "log"
    status = "Enabled"

    expiration {
      days = 365  # 365日後に削除
    }
  }
}

# サーバーサイド暗号化（SSE）の設定
# AES256アルゴリズムを使用
resource "aws_s3_bucket_server_side_encryption_configuration" "sse_config" {
  bucket = aws_s3_bucket.image_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"  # AES256で暗号化
    }
  }
}
