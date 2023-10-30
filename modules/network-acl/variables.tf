# VPC IDの設定
variable "vpc_id" {
  description = "The ID of the VPC where the NACL will be created."  // Network ACLを作成するVPCのID
  type        = string
}


