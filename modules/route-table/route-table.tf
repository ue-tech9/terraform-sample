resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.destination
    gateway_id = var.target
  }

  tags = {
    Name = var.name
  }
}
