variable "vpc_id" {
  description = "VPCのID"
}

variable "subnet_group_name" {
  description = "サブネットグループ名"
}

variable "subnet_ids" {
  description = "サブネットIDのリスト"
  type        = list(string)
}


variable "security_group" {
  description = "セキュリティグループ"
}

variable "aurora_cluster_name" {
  description = "Auroraクラスタの名前"
}

variable "aurora_instance_name" {
  description = "Auroraインスタンスの名前"
}

variable "master_username" {
  description = "マスターユーザー名"
}

variable "master_password" {
  description = "マスターパスワード"
}

variable "instance_class" {
  description = "DBインスタンスクラス"
}
