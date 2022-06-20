# AWS region 
region          = "ap-south-1"

# Environment name
environment     = "demo"

# VPC cidr block
vpc_cidr        = "10.0.0.0/16"

# Public subnet range
public_subnets_cidr     = ["10.0.16.0/20", "10.0.32.0/20"]

# Private subnet range
private_subnets_cidr     = ["10.0.112.0/20", "10.0.144.0/20"]

# Load balancer type; Keep it is as "application" for demo
lb_type     = "application"

# Public facing or internal load balancer
lb_internal     = false

# To create a new key pair or use an existing one. 
create_new_key_pair = true

# SSH file path, if above it "true"
ssh_key_filename     = "~/.ssh/demo-app.pub"

# Existing SSH key-pair
key_pair_existing = "root-key"

# Type of SPOT ec2 instance
instance_type     = "t2.micro"

# Size of root EBS
root_volume_size     = 8

# SPOT ec2 max price
spot_price     = 0.0037 

# Minimum size of EC2 
min_size     = 1

# Maximum size of EC2 
max_size     = 2

# Desired size of EC2 
desired_capacity     = 1

# Target type for load balancer (ALB); Keep it is as "instance" for demo
target_type     = "instance"

# SNS protocol for subscription; Keep it is as "email" for demo
protocol     = "email" 

# Email endpoint for the alarm notification from cloudwatch
endpoint     = "email@id.com" # ChangeMe to valid endpoint


