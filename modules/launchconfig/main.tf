data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "aws_availability_zones" "all" {}

resource "aws_key_pair" "demo_app_key" {
  key_name   = var.ssh_key_pair_name
  public_key = file(var.ssh_key_filename)

  lifecycle {
      ignore_changes = ["public_key"]
    }
}

resource "aws_launch_configuration" "demo_app_lc" {

  name                  = var.launch_configuration_name
  image_id              = data.aws_ami.ubuntu.id
  instance_type         = var.instance_type
  spot_price            = var.spot_price
  security_groups       = var.security_groups
  key_name              = aws_key_pair.demo_app_key.key_name
  user_data = <<-EOF
              #!/bin/bash
              sudo apt install nginx -y
              sudo systemctl start nginx
              EOF

  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_volume_size
    delete_on_termination = true
  }
  
  ebs_block_device {
    volume_type = "gp2"
    device_name = "/dev/sdb"
    volume_size = 5
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "demo_app_as" {
  name                 = var.autoscaling_group_name
  launch_configuration = aws_launch_configuration.demo_app_lc.name
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  vpc_zone_identifier  = var.vpc_zone_identifier
  
  enabled_metrics      = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]


  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "demo-app-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }

}

# load balancer attachment to Autoscaling group

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.demo_app_as.name
  alb_target_group_arn   = var.lb_target_group_arn

}

resource "aws_autoscaling_policy" "demo-asg-policy" {
  
  name                   = "demo-asg-scaling-policy"
  autoscaling_group_name = aws_autoscaling_group.demo_app_as.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 40.0
  }
}
