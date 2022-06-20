variable "region" {
  description = "AWS region when resouces should be created"
  default     = "ap-south-1"
}

variable "environment" {
  type        = string
  description = "Deployment Environment"
  default     = "demo"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnets_cidr" {
  type        = list(string)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.112.0/20", "10.0.144.0/20"]
}

# Security group

# variable "lg_sg_name" {
#   type        = string
#   description = "Load balancer security group name"
#   default     = "demo-alb-sg"
# }

# variable "app_sg_name" {
#   type        = string
#   description = "Application security group name"
#   default     = "demo-app-sg"
# }

# variable "lb_name" {
#   type        = string
#   description = "Application load balancer name"
#   default     = "demo-alb"
# }

variable "lb_type" {
  type        = string
  description = "Type of load balancer"
  default     = "application"
}

variable "lb_internal" {
  type        = bool
  description = "For internal, it should be 'true'"
  default     = false
}

# variable "alb_bucket_name" {
#   type        = string
#   description = "Bucket for access logs"
#   default     = "demo-alb-access-s3"
# }

# Launch config

# variable "launch_configuration_name" {
#   type        = string
#   description = "Name of launch config"
#   default     = "demo-app-launch-config"
# }

# variable "ssh_key_pair_name" {
#   type        = string
#   description = "SSH key-pair key name"
#   default     = "demo-app-key"
# }

variable "create_new_key_pair" {
  description = "To create key pair or not"
  default     = false
}
variable "ssh_key_filename" {
  description = "public key file path"
  default     = "~/.ssh/id_rsa.pub"
}
variable "key_pair_existing" {
  description = "If create_new_key_pair is false, provide existing key pair name here."
  default     = "key-pair-name-already-available"
}

variable "instance_type" {
  type        = string
  description = "Instance type of spot instance"
  default     = "t2.micro"
}

variable "root_volume_size" {
  type        = number
  description = "Root volume size for EC2"
  default     = 8
}

variable "spot_price" {
  type        = any
  description = "Spot instance max price"
  default     = 0.0037
}


# variable "autoscaling_group_name" {
#   type        = string
#   description = "Name of autoscaling group"
#   default     = "demo-app-asg"
# }

variable "min_size" {
  type        = number
  description = "Min capacity in Autoscaling group"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Max capacity in Autoscaling group"
  default     = 2
}

variable "desired_capacity" {
  type        = number
  description = "Desired capacity in Autoscaling group"
  default     = 1
}

variable "target_type" {
  type        = string
  description = "Target type of the Target group"
  default     = "instance"
}

# Alarm cloudwatch

# variable "aws_sns_topic_name" {
#   type        = string
#   description = "Name of the SNS topic"
#   default     = "demo-app-sns-topic"
# } 

variable "protocol" {
  type        = string
  description = "Protcol to attach with sns topic" # Ex: email
  default     = "email"
} 

variable "endpoint" {
  type        = string
  description = "Endpoint for the sns notifications"
  default     = "email@id.com" # ChangeMe
} 

# variable "metric" {
#   type        = string
#   description = "Metric Name for the Autoscaling alert alarm"
#   default     = "CPUUtilization"
# } 

# variable "threshold" {
#   type        = number
#   description = "Threshold value for the metrics alarm"
#   default     = 50
# } 



