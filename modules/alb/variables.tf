# 各種変数の定義

# ALBの名前
variable "alb_name" {
  description = "ロードバランサーの名前"
  type        = string
}

# ALBのスキーム
variable "scheme" {
  description = "スキーム（internet-facing または internal）"
  type        = string
  default     = "internet-facing"
}

# ALBのIPアドレスタイプ
variable "ip_address_type" {
  description = "IPアドレスのタイプ（ipv4）"
  type        = string
  default     = "ipv4"
}

# VPCのID
variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

# サブネットのID
variable "subnet_ids" {
  description = "サブネットIDのリスト"
  type        = list(string)
}

# セキュリティグループのID
variable "security_group_ids" {
  description = "セキュリティグループIDのリスト"
  type        = list(string)
}

# SSL証明書のARN
variable "certificate_arn" {
  description = "The ARN of the SSL certificate"
  default     = null
}
