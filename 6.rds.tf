resource "aws_db_subnet_group" "default" {
  name       = var.name
  subnet_ids = [for subnet in aws_subnet.public : subnet.id]
}