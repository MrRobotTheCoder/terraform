resource "aws_autoscaling_group" "my_asg" {
  name_prefix   = "myasg-"
  desired_capacity   = 2
  max_size           = 10
  min_size           = 2
  vpc_zone_identifier = module.vpc.private_subnets

  target_group_arns = [module.alb.target_groups["mytg1"].arn]

  health_check_type = "EC2"
  health_check_grace_period = 300

  launch_template {
    id = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version    
  }
  # Instance Refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }
  # Tags
  tag {
    key                 = "Owners"
    value               = "Web-Team"
    propagate_at_launch = true
  }
}