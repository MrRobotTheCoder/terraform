# Security Group for Public Bastion Host

module "private-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "private-sg"
  description = "Security Group with HTTP & SSH port open for entire VPC Block (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules and CIDR Blocks
  #ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp", "http-80-tcp","http-8080-tcp"]


  # Egress Rules and CIDR Blocks : all-all Open
  egress_rules = ["all-all"]
  tags = local.common_tags
}