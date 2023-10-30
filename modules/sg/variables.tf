# セキュリティグループの名前に関する変数
variable "name" {
  description = "セキュリティグループの名前"  
  type        = string                          # 変数の型（文字列）
}

# セキュリティグループの説明に関する変数
variable "description" {
  description = "セキュリティグループの説明"  
  type        = string                        # 変数の型（文字列）
  default     = "No description"                    # デフォルト値
}

# VPC IDに関する変数
variable "vpc_id" {
  description = "セキュリティグループを作成するVPCのID"  
  type        = string                                    # 変数の型（文字列）
}

# インバウンドルールに関する変数
variable "ingress_rules" {
  description = "セキュリティグループのインバウンドルール"  
  type        = list(object({                                # 変数の型（オブジェクトのリスト）
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []  # デフォルト値（空のリスト）
}

# アウトバウンドルールに関する変数
variable "egress_rules" {
  description = "セキュリティグループのアウトバウンドルール"  
  type        = list(object({                                 # 変数の型（オブジェクトのリスト）
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default     = []  # デフォルト値（空のリスト）
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"  // 変数の説明：この変数はAWSリソースに割り当てるタグのマッピングです。
  type        = map(string)  // 変数の型：文字列のキーと値を持つマップ型です。
  default     = {}  // デフォルト値：何も指定されていない場合、この変数は空のマップとして初期化されます。
}

