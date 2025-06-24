# ASG: Target Tracking Scaling Policy

# Scaling Policy 1 : Based on CPU Utilization of EC2 Instances
resource "aws_autoscaling_policy" "avg_cpu_utilization" {
  name                   = "avg_cpu_utilization"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }  
}

# Scaling Policy 2 : Based on ALB Target Requests
resource "aws_autoscaling_policy" "alb_target_requests" {
  name                   = "alb_target_requests"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my_asg.id
  estimated_instance_warmup = 180
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label =  "${module.alb.lb_arn_suffix}/${module.alb.target_group_arn_suffixes[0]}"
    }
    target_value = 10.0
  }  
}

