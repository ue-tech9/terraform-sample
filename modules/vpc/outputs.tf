output "vpc_id" {
  description = "VPCのID"
  value       = aws_vpc.sample_dev_vpc.id
}

output "vpc_arn" {
  description = "VPCのARN"
  value       = aws_vpc.sample_dev_vpc.arn
}
