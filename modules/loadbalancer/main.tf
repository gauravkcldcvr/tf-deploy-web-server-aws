locals {
  alb_root_account_id = "718504428378" # valid account id for Mumbai Region. Full list -> https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-access-logs.html
}

resource "aws_s3_bucket" "alb_logs" {
  bucket = var.alb_bucket_name
  force_destroy = true
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowELBRootAccount",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${local.alb_root_account_id}:root"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.alb_bucket_name}/*"
    },
    {
      "Sid": "AWSLogDeliveryWrite",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:PutObject",
      "Resource": "arn:aws:s3:::${var.alb_bucket_name}/*",
      "Condition": {
        "StringEquals": {
          "s3:x-amz-acl": "bucket-owner-full-control"
        }
      }
    },
    {
      "Sid": "AWSLogDeliveryAclCheck",
      "Effect": "Allow",
      "Principal": {
        "Service": "delivery.logs.amazonaws.com"
      },
      "Action": "s3:GetBucketAcl",
      "Resource": "arn:aws:s3:::${var.alb_bucket_name}"
    }
  ]
}
POLICY

  tags = {
    Name        = "${var.name}-access-logs"
    Environment = "${var.name}"
  }
}

resource "aws_lb" "demo-lb" {
  name               = var.name
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = var.security_groups
  subnets            = var.subnets


  access_logs {
    bucket  = aws_s3_bucket.alb_logs.bucket
    prefix  = "${var.name}-lb-logs"
    enabled = true
  }

  tags = {
    Environment = "${var.name}"
    Name        = "${var.name}-application"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "demo-app-http-tg" {
  name            = "app-http-tg"
  port            = 80
  protocol        = "HTTP"
  target_type     = var.target_type
  vpc_id          = var.vpc_id

}

resource "aws_lb_listener" "demo_http_listner" {
  load_balancer_arn = aws_lb.demo-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.demo-app-http-tg.arn
  }
}

# resource "aws_lb_target_group_attachment" "demo_app_tg_attach" {
#   target_group_arn = aws_lb_target_group.demo-app-http-tg.arn
#   target_id        = var.target_id
#   port             = 80
# }
