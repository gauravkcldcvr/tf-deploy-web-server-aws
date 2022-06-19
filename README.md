# Deploy sample nginx web-server with ALB
#### This terraform creates following resources in AWS - 

## Features

1. VPC
2. 4 Subnets (two public and two private) which includes creation of NAT and IG gateway. 
3. Two Security group for Load balancer (public) and application level (private).
4. A EC2 launch configuration with autoscaling group and with attached target scaling policy based on CPUUtilisation metric threshold.
5. Creates initially a single SPOT ec2 (t2.micro) instance in private subnet.
6. Included 8GiB as primary root volume and 5GiB secondary storage (default) mount at "/dev/sdb" from launch config in auto scaling group.
7. An internet facing application load balancer which exposes our nginx web-server on port 80 (HTTP) deployed in private subnet.
8. S3 bucket to store the ALB access logs and to store encrypted terraform state in s3 bucket
9. SNS topic as email notification for cloudwatch alarms to trigger sample "CPUUtilisation" metric threshold alert for autoscaling group.

### Note
This creates resources which are chargeable.

## Installation

Terraform provider version

```
required_version = "<= 0.12.14"
```

Configure AWS profile with credentials locally with appropriate access
```
aws configure
```

Clone the repo
```
$ git clone https://github.com/kararag/tf-demo-web-server.git
```

Update all the mandatory parameters in file  "terraform.tfvars". By default it creates with demo values in region "ap-south-1". It's tested with default values provided in the terraform.tfvars using ALB. For email notification, it's sns subscription needs to be confirmed from valid email endpoint to get alarms.

To check the parameters 

```$ vi terraform.tfvars```

For S3 backend, update the s3 bucket name in file "backend.tf"

```$ vi backend.tf```

To check the terraform plan and verify

```$ terraform plan```

To create resources from the plan; confirm "yes"

```$ terraform apply```

wait for a few minutes till the resources are finished creating...

To get the ALB DNS endpint, refer to "**aws_lb_dns**" value in output.

```Use the end point value from above output, you should see that redirecting to a demo nginx page```

To destroy the resource stack completely

```$ terraform plan --destroy```

```$ terraform destroy --auto-approve```

