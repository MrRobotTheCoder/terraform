# Public Bastion Host Security Group Outputs
# Public Bastion Host SG group ID
output "public_bastion_security_group_id" {
  description = "The ID of the security group"
  value       = module.public_bastion_sg.security_group_id
}
# Public Bastion Host SG VPC ID
output "public_bastion_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.public_bastion_sg.security_group_vpc_id
}

# Public Bastion Host SG group name
output "public_bastion_security_group_name" {
  description = "The name of the security group"
  value       = module.public_bastion_sg.security_group_name
}


# Private Security Group Outputs
# Private SG group ID
output "private_security_group_id" {
  description = "The ID of the security group"
  value       = module.private-sg.security_group_id
}
# Private SG VPC ID
output "private_security_group_vpc_id" {
  description = "The VPC ID"
  value       = module.private-sg.security_group_vpc_id
}

# Private SG group name
output "private_security_group_name" {
  description = "The name of the security group"
  value       = module.private-sg.security_group_name
}