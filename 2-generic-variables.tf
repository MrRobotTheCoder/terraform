# AWS Region
variable "aws_region" {
    description = "The Region in which AWS resources will be created"
    type = string
    default = "us-east-1"  
}

# Environment Variables
variable "environment" {
  description = "Environment Variable used as a prefix"
  type = string
  default = "dev"
}

# Business Division
variable "business_division" {
    description = "Business Division in the large Organization"
    type = string
    default = "SAP"  
}
