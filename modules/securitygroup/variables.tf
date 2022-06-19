variable "vpc_id" {
  type        = any
} 

variable "lg_sg_name" {
  type        = string
  description = "Load balancer security group name"
}

variable "app_sg_name" {
  type        = string
  description = "Application security group name"
}
