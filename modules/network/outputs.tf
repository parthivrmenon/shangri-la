output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "primary_subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.main.id
}

output "secondary_subnet_id" {
  description = "The ID of the Subnet"
  value       = aws_subnet.secondary.id
}