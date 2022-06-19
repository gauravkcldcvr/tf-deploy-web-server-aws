# variable "aws_sns_topic_name" {
#   type        = string
# } 

variable "protocol" {
  type        = string
} 

variable "endpoint" {
  type        = string
} 

# variable "metric" {
#   type        = string
# } 

# variable "threshold" {
#   type        = number
# } 

variable "autoscaling_group_name" {
  type        = any
  
}