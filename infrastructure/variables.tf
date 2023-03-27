# define variables

variable "aws_region" {
  default = "us-east-2"
}

variable "prefix" {
  default = "igti-fabio-rais"
}

variable "account" {
  default = 387875303309
}

variable "key_pair_name" {
  default = "EMR-IGTI-delta"
}

# prefix configuration and project common tags

locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Project      = "RAIS"
    ManagedBy    = "Terraform"
    Department   = "XPed",
    Provider     = "IGTI",
    Owner        = "Data Engineering"
    BusinessUnit = "Data"
    Billing      = "Infrastructure"
    Environment  = terraform.workspace
    UserEmail    = "fabio.nf@live.com"
  }
}

variable "bucket_name" {
  default = "datalake-igti-fabio-rais"
}