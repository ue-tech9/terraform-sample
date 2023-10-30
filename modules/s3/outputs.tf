output "image_bucket_arn" {
  description = "画像保存用バケットのARN"
  value       = aws_s3_bucket.image_bucket.arn
}

output "alb_log_bucket_arn" {
  description = "ALBログ保存用バケットのARN"
  value       = aws_s3_bucket.alb_log_bucket.arn
}
