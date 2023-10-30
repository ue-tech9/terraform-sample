variable "vpc_id" {
  description = "The VPC ID."
}

variable "name" {
  description = "The name of the route table."
}

variable "destination" {
  description = "The destination CIDR block."
}

variable "target" {
  description = "The target gateway ID."
}
