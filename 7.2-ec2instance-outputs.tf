# AWS EC2 Instance Terraform Outputs
# Public EC2 Instances - Bastion Host

## ec2_bastion_public_instance_ids
output "ec2_bastion_public_instance_ids" {
  description = "EC2 instance ID"
  value       = module.ec2-public-instance.id
}

## ec2_bastion_public_ip
output "ec2_bastion_public_ip" {
  description = "Public IP address EC2 instance"
  value       = module.ec2-public-instance.public_ip 
}

# Private EC2 Instances
## App1 ec2_private_instance_ids
output "app1_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2-private-instance_app1: ec2private.id ]   
}

## App1 ec2_private_ip
output "app1_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-private-instance_app1: ec2private.private_ip ]
}

## App2 ec2_private_instance_ids
output "app2_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2-private-instance_app2: ec2private.id ]   
}

## App3 ec2_private_instance_ids
output "app3_ec2_private_instance_ids" {
  description = "List of IDs of instances"
  value = [for ec2private in module.ec2-private-instance_app3: ec2private.id ]   
}

## App2 ec2_private_ip
output "app2_ec2_private_ip" {
  description = "List of private IP addresses assigned to the instances"
  value = [for ec2private in module.ec2-private-instance_app2: ec2private.private_ip ]
}