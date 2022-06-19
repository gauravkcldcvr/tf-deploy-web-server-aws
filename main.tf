resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  production_availability_zones = ["${var.region}a", "${var.region}b", "${var.region}c"]
}

module "vpc" {
  source               = "./modules/vpc"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  availability_zones   = local.production_availability_zones

}

module "loadbalancer" {
  source               = "./modules/loadbalancer"
  lb_name              = var.lb_name
  lb_type              = var.lb_type
  lb_internal          = var.lb_internal
  subnets              = module.vpc.public_subnets_id[*].id
  security_groups      = module.securitygroup.lb_sg_id[*].id
  alb_bucket_name      = var.alb_bucket_name
  vpc_id               = module.vpc.vpc_id.id
  target_type          = var.target_type 
  target_id            = module.loadbalancer.aws_lb_id
  
}

module "securitygroup" {
  source               = "./modules/securitygroup"
  lg_sg_name           = var.lg_sg_name
  vpc_id               = module.vpc.vpc_id.id
  app_sg_name          = var.app_sg_name

}

module "launchconfig" {
  source                    = "./modules/launchconfig"
  launch_configuration_name = var.launch_configuration_name
  security_groups           = module.securitygroup.app_sg_id[*].id
  ssh_key_pair_name         = var.ssh_key_pair_name
  ssh_key_filename          = var.ssh_key_filename
  instance_type             = var.instance_type
  spot_price                = var.spot_price
  root_volume_size          = var.root_volume_size
  autoscaling_group_name    = var.autoscaling_group_name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = var.desired_capacity
  vpc_zone_identifier       = module.vpc.private_subnets_id[*].id
  lb_target_group_arn       = module.loadbalancer.aws_lb_tg_id

 
}

module "alarm" {
  source                    = "./modules/alarm"
  aws_sns_topic_name        = var.aws_sns_topic_name
  protocol                  = var.protocol
  endpoint                  = var.endpoint
  metric                    = var.metric
  threshold                 = var.threshold
  autoscaling_group_name    = module.launchconfig.aws_asg_name
  
}