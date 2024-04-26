# ---------------------------------------------
# Variables
# ---------------------------------------------
variable "region" {}
variable "name" {}
variable "vpc_cidr" {}
variable "public_subnet_cidrs" { type = map(string) }
variable "private_subnet_cidrs" { type = map(string) }
variable "db_name" {}
variable "db_username" {}
variable "access_key" {}
variable "secret_key" {}
