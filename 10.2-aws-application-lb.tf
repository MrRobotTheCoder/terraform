# AWS Application Load Balancers
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"
  
  load_balancer_type = "application"
  name    = "${local.name}-alb"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.public_subnets
  security_groups = [module.loadbalancer-sg.security_group_id]
  tags = local.common_tags

  # Listeners
  listeners = {
    # Listner-1: my-http-listener
    my-http-listener = {
      port                        = 80
      protocol                    = "HTTP"
      
      forward = {
        target_group_key = "my_target_group"
      }
    }# End of my-http-listener
  }# End of Listeners Block

  # Target Groups
  target_groups = {
    my_target_group = {
      create_attachment = false
      name_prefix                       = "mytg-"
      protocol                          = "HTTP"
      port                              = 80
      target_type                       = "instance"
      deregistration_delay              = 10
      load_balancing_cross_zone_enabled = false
      protocol_version = "HTTP1"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
           
      tags = local.common_tags      
    }
  }
}

  # Load Balancer Target Group Attachment 
  ## k = ec2_instance
  ## v = ec2_instance_details
  resource "aws_lb_target_group_attachment" "my_target_group" {
  for_each = {for k, v in module.ec2-private-instance: k => v}
  target_group_arn = module.alb.target_groups["my_target_group"].arn
  target_id        = each.value.id
  port             = 80
}

# Temporary App Outputs
output "test_ec2_private" {
  value = {for k, v in module.ec2-private-instance: k => v}
}