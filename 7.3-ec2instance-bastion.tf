# Bastion Host - EC2 Instance that will be created in VPC Public Subnet.

module "ec2-public-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name                      = "${var.environment}-BastionHost"
  ami                       = data.aws_ami.amz_linux2.id
  instance_type             = var.instance_type
  key_name                  = var.instance_keypair
  #monitoring               = true
  subnet_id                 = module.vpc.public_subnets[0]
  vpc_security_group_ids    = [module.public_bastion_sg.security_group_id]
  tags = local.common_tags
  
}


