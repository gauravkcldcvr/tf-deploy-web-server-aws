terraform {
  backend "s3" {
    bucket  = "demo-backend"
    key     = "demo/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true
  }
}