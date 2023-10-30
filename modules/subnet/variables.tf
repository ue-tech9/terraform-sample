variable "vpc_id" {
  description = "VPCのID"
  type        = string
}

variable "public_subnets" {
  description = "Publicサブネットの設定"
  type        = list(object({ name = string, cidr = string, az = string }))
}

variable "protected_subnets" {
  description = "Protectedサブネットの設定"
  type        = list(object({ name = string, cidr = string, az = string }))
}

variable "datastore_subnets" {
  description = "Datastoreサブネットの設定"
  type        = list(object({ name = string, cidr = string, az = string }))
}
