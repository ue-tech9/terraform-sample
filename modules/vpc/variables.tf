variable "vpc_name" {
  description = "VPCの名前"
  type        = string
  default     = "sample-dev-vpc"
}

variable "vpc_cidr" {
  description = "VPCのCIDRブロック"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tenancy" {
  description = "VPCのインスタンス・テナンシー"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "VPCでDNSホスト名を有効にするかどうか"
  type        = bool
  default     = true
}

variable "enable_ipv6" {
  description = "VPCでIPv6を有効にするかどうか"
  type        = bool
  default     = false
}

