# Security Group for Public Bastion Host

module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "public-bastion-sg"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules and CIDR Blocks
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules = ["ssh-tcp"]

  # Egress Rules and CIDR Blocks : all-all Open
  egress_rules = ["all-all"]
  tags = local.common_tags

}