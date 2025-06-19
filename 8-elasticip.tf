resource "aws_eip" "bastion_eip" {
  depends_on = [ 
    module.ec2-public-instance,
    module.vpc 
   ]
  instance = module.ec2-public-instance.id
  domain   = "vpc"
  tags = local.common_tags
}
