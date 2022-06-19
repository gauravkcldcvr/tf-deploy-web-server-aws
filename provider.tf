terraform {
    required_version = "<= 0.12.14"
}

provider "aws" {
  region = var.region
}