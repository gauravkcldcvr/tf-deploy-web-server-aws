resource "aws_sns_topic" "demo_app_topic" {
  name = var.aws_sns_topic_name
}

resource "aws_sns_topic_subscription" "demo_app_topic_sub" {
  topic_arn = aws_sns_topic.demo_app_topic.arn
  protocol  = var.protocol
  endpoint  = var.endpoint
}

resource "aws_cloudwatch_metric_alarm" "demo_app_load_alarm" {
  alarm_name                = var.metric
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = var.metric
  namespace                 = "AWS/EC2"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = var.threshold
  alarm_description         = "This metric monitors ec2 cpu utilization"
  actions_enabled           = "true"
  alarm_actions             = [aws_sns_topic.demo_app_topic.arn]

  dimensions = {
    AutoScalingGroupName    = var.autoscaling_group_name
  }

}

