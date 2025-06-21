# Security Group for Classic Load Balancer
module "loadbalancer-sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"

  name = "loadbalancer-sg"
  description = "Security Group with HTTP open for entire internet (IPv4 CIDR), egress ports are all world open"
  vpc_id = module.vpc.vpc_id

  # Ingress Rules and CIDR Blocks
  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  # Egress Rules and CIDR Blocks : all-all Open
  egress_rules = ["all-all"]
  tags = local.common_tags

  ingress_with_cidr_blocks = [
    
    {
      from_port   = 81
      to_port     = 81
      protocol    = 6
      description = "Allow port 81 from Internet"
      cidr_blocks = "0.0.0.0/0"
    },
  ]

}