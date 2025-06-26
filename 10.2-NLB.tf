module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name_prefix = "my-nlb-"
  load_balancer_type               = "network"
  vpc_id                           = module.vpc.vpc_id
  dns_record_client_routing_policy = "availability_zone_affinity"
  security_groups = [module.loadbalancer-sg.security_group_id]

  # https://github.com/hashicorp/terraform-provider-aws/issues/17281
  subnets = module.vpc.private_subnets
 
  # For example only
  enable_deletion_protection = false

 # listeners Block
  listeners = {
    # Listener 1
    my-tcp = {
      port     = 80
      protocol = "TCP"
      forward = {
        target_group_key = "mytg1"
      }
    } # End of Listener 1

    # Listener 2 SSL
    my-tls = {
      port            = 443
      protocol        = "TLS"
      certificate_arn = module.acm.acm_certificate_arn
      forward = {
        target_group_key = "mytg1"
      }
    }  # End of Listener 2 SSL
  }

  # Target Group Block
  target_groups = {
    mytg1 = {
      create_attachment = false
      name_prefix            = "mytg1-"
      protocol               = "TCP"
      port                   = 80
      target_type            = "instance"
      target_id              = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }
    }

  }

  tags = local.common_tags

}