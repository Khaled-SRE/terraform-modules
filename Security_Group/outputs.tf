output "security_group_name" {
  value = aws_security_group.sg.name
}
output "security_group_arn" {
  value = aws_security_group.sg.arn
}
output "security_group_vpc_id" {
  description = "The VPC ID"
  value       = aws_security_group.sg.vpc_id
}
output "security_group_owner_id" {
  description = "The owner ID"
  value       = aws_security_group.sg.owner_id
}
output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.sg.id
}
output "security_group_description" {
  description = "The description of the security group"
  value       = aws_security_group.sg.description
}