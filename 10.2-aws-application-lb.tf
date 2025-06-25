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

  enable_deletion_protection = false
  
  # Listeners
  listeners = {
    # Listner-1: my-http-https-redirect
    my-http-https-redirect = {
      port                        = 80
      protocol                    = "HTTP"
      redirect = {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
      
    }# End of Listner1 - my-http-https-redirect
    # 
    # Start of Listner2 - my-https-listener 
    my-https-listener = {
      port                        = 443
      protocol                    = "HTTPS"
      ssl_policy                  = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
      certificate_arn             = module.acm.acm_certificate_arn
       
       # Fixed Response for Root Context 
       fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }# End of Fixed Response 
      # Load Balancer Rules
      rules = {
        # Rule-1: myapp1-rule
        myapp1-rule = {
          actions = [{
            type = "weighted-forward"
            target_groups = [
              {
                target_group_key = "target_group_1"
                weight           = 1
              }
            ]
            stickiness = {
              enabled  = true
              duration = 3600
            }
          }]
          conditions = [{
            path_pattern = {
              values = ["/*"]
            }
          }]
        }# End of myapp1-rule
    }# End of Listener Block
    
  }# End of Listeners Block 

  # Target Groups1
  target_groups = {
    target_group_1 = {
      create_attachment = false
      name_prefix                       = "mytg1-"
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
}