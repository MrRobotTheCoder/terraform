# EC2 Instance that will be created in VPC Private Subnets.

module "ec2-private-instance" {
  depends_on = [ module.vpc ] 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "5.8.0"

  name                      = "${var.environment}-private-ec2-vm"
  ami                       = data.aws_ami.amz_linux2.id
  instance_type             = var.instance_type
  key_name                  = var.instance_keypair
  vpc_security_group_ids    = [module.private-sg.security_group_id]
  for_each = toset(["0", "1"])
  subnet_id = element(module.vpc.private_subnets, tonumber(each.key))
  user_data = file("${path.module}/app1-install.sh")
  
  tags = local.common_tags

}