# 各種変数の定義

# VPC ID
variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

# サブネットID
variable "subnets" {
  description = "サブネットのIDのリスト"
  type        = list(string)
}

# 可用性ゾーン
variable "availability_zones" {
  type = list(string)
}

# AMI ID
variable "ami_id" {
  type        = string
  description = "AMI ID for instances"
}

# SSHキー名
variable "key_name" {
  type        = string
  description = "SSH key name for instances"
}

# ASG名
variable "asg_name" {
  type = string
}

# 最小サイズ
variable "min_size" {
  type = number
}

# 最大サイズ
variable "max_size" {
  type = number
}

# プライベートサブネットID
variable "protected_subnet_ids" {
  description = "List of IDs of private subnets"
  type        = list(string)
  default     = []
}

# インスタンスタイプ
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"  // デフォルト値
}
