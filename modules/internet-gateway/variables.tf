# インターネットゲートウェイが作成されるVPCのID
variable "vpc_id" {
  description = "The ID of the VPC where the Internet Gateway will be created."
  type        = string
}

# インターネットゲートウェイの名前タグ
variable "name" {
  description = "The name tag for the Internet Gateway."
  type        = string
  default     = "sample-dev-igw"  # デフォルト名
}


