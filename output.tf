output "aws_lb_dns" {
  value = module.loadbalancer.aws_lb_dns
  description = "The load balancer DNS for nginx web server"
}

# output "vpc_id" {
#   value = module.vpc.vpc_id.id
# }

# output "public_subnets_id" {
#   value = module.vpc.public_subnets_id[*].id
# }

# output "private_subnets_id" {
#   value = module.vpc.private_subnets_id[*].id
# }

# # Security group components output 

# output "lb_sg_id" {
#   value = module.securitygroup.lb_sg_id[*].id
# }

# output "app_sg_id" {
#   value = module.securitygroup.app_sg_id[*].id
# }

# # Application load balancer output 

# output "aws_lb_id" {
#   value = module.loadbalancer.aws_lb_id
# }

# output "aws_lb_name" {
#   value = module.loadbalancer.aws_lb_name
# }

# output "aws_lb_tg" {
#   value = module.loadbalancer.aws_lb_tg
# }

# output "aws_lb_tg_id" {
#   value = module.loadbalancer.aws_lb_tg
# }

# output "aws_asg_name" {
#   value = module.launchconfig.aws_asg_name
# }