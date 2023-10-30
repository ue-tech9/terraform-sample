variable "image_bucket_name" {
  description = "画像保存用のS3バケット名"
  type        = string
}

variable "alb_log_bucket_name" {
  description = "ALBログ保存用のS3バケット名"
  type        = string
}
