# AWS region;  Mandatory to pass region name
region          = "ap-south-1"

# Environment name; Mandatory to pass any env/app name
environment     = "demo"

# VPC cidr block; Mandatory to pass VPC CIDR
vpc_cidr        = "10.0.0.0/16"

# Public subnet range; Mandatory to pass subnets CIDR
public_subnets_cidr     = ["10.0.16.0/20", "10.0.32.0/20"]

# Private subnet range; Mandatory to pass subnets CIDR
private_subnets_cidr     = ["10.0.112.0/20", "10.0.144.0/20"]

# Load balancer type; Mandatory to keep it as "application" for ALB
lb_type     = "application"

# Public facing or internal load balancer; Mandatory to keep as "false" for internet facing
lb_internal     = false

# To create a new key pair or use an existing one; Mandatory to set to "true"
create_new_key_pair = true

# Full path of the SSH public key; Mandatory to pass when "create_new_key_pair" is set to "true"
ssh_key_filename     = "~/.ssh/demo-app.pub"

# Pass the name of existing key pair; Mandatory to use a new key pair by setting "create_new_key_pair" is set to "true"
key_pair_existing = "root-key"

# Type of SPOT ec2 instance; Default keeping as "t2.micro" type
instance_type     = "t2.micro"

# Size of root EBS; Default keeping as "8" GiB
root_volume_size     = 8

# SPOT ec2 max price; Default keeping as "0.0037" for "t2.micro" type
spot_price     = 0.0037 

# Minimum size of EC2; Default keeping as "1"
min_size     = 1

# Maximum size of EC2; Default keeping as "2"
max_size     = 2

# Desired size of EC2 
desired_capacity     = 1

# Target type for load balancer (ALB); Mandatory to keep it as "instance" for this case.
target_type     = "instance"

# SNS protocol for subscription; Mandatory to keep it is as "email" for this case. 
protocol     = "email" 

# Email endpoint for the alarm notification from cloudwatch
endpoint     = "email@id.com" # ChangeMe to valid endpoint


