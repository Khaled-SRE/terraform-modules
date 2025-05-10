output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr_blocks" {
  description = "List of CIDR blocks for the VPC"
  value       = [aws_vpc.main_vpc.cidr_block]
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnet[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnet[*].id
}

output "private_subnet_cidrs" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnet[*].cidr_block
}

output "public_subnet_cidrs" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnet[*].cidr_block
}


