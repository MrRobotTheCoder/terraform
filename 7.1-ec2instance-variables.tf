# EC2 Instance Variables

# AWS EC2 Instance Type
variable "instance_type" {
    description = "The type of EC2 instance that will be created."
    type = string
    default = "t3.micro"  
}

# AWS EC2 Instance Key Pair
variable "instance_keypair" {
    description = "The EC2 key pair that needs to be associated with EC2 Instance"
    type = string
    default = "aws-devops-key"
}

# AWS EC2 Private Instance Count
/*variable "private_instance_count" {
    description = "AWS EC2 Private Instance Count"
    type = number
    default = 1  
}*/