# NATゲートウェイの名前
variable "name" {
  description = "The name of the NAT Gateway"
  type        = string
}

# NATゲートウェイに関連付けるサブネットのID
variable "subnet_id" {
  description = "The ID of the subnet to associate with the NAT Gateway"
  type        = string
}
