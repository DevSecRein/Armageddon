resource "aws_autoscaling_group" "Ultramarines_LDN_asg" {
  provider = aws.Londres
  name_prefix           = "Ultramarines_LDN-auto-scaling-group-"
  min_size              = 3
  max_size              = 9
  desired_capacity      = 6
  vpc_zone_identifier   = [
    aws_subnet.private-eu-west-2a.id,
    aws_subnet.private-eu-west-2b.id
  ]
  health_check_type          = "ELB"
  health_check_grace_period  = 300
  force_delete               = true
  target_group_arns          = [aws_lb_target_group.Ultramarines_LDN_tg.arn]

  launch_template {
    id      = aws_launch_template.Ultramarines_LDN_LT.id
    version = "$Latest"
  }

  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]

  # Instance protection for launching
  initial_lifecycle_hook {
    name                  = "instance-protection-launch"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_LAUNCHING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 60
    notification_metadata = "{\"key\":\"value\"}"
  }

  # Instance protection for terminating
  initial_lifecycle_hook {
    name                  = "scale-in-protection"
    lifecycle_transition  = "autoscaling:EC2_INSTANCE_TERMINATING"
    default_result        = "CONTINUE"
    heartbeat_timeout     = 300
  }

  tag {
    key                 = "Name"
    value               = "Ultramarines_LDN-instance"
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = "Production"
    propagate_at_launch = true
  }
  
  lifecycle {
    create_before_destroy = true
  }
}


# Auto Scaling Policy
resource "aws_autoscaling_policy" "Ultramarines_LDN_scaling_policy" {
  provider = aws.Londres
  name                   = "Ultramarines_LDN-cpu-target"
  autoscaling_group_name = aws_autoscaling_group.Ultramarines_LDN_asg.name

  policy_type = "TargetTrackingScaling"
  estimated_instance_warmup = 120

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 75.0
  }
}

# Enabling instance scale-in protection
resource "aws_autoscaling_attachment" "Ultramarines_LDN_asg_attachment" {
  provider = aws.Londres
  autoscaling_group_name = aws_autoscaling_group.Ultramarines_LDN_asg.name
  lb_target_group_arn   = aws_lb_target_group.Ultramarines_LDN_tg.arn
}