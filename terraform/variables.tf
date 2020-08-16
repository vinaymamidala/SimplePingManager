# general

variable "region" {
  type    = string
  default = "us-east-1"
}

variable "route_53_zone" {
  type    = string
  default = "aws.easyaws.in"
}

variable "private_deploy" {
  type    = bool
  default = false
}

variable "private_cidr" {
  type    = string
  default = "49.206.32.53/32"
}

variable "ec2_instance_type" {
  type    = string
  default = "t3.medium"
}

# services

variable "app_ami_id" {
  type    = string
  default = "ami-0b17d2af6c99a11da"
}

# tags

variable "owner" {
  type    = string
  default = "easyaws"
}

variable "env" {
  type    = string
  default = "learn"
}

variable "git_commit" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "service" {
  description = "Name of the service"
  default     = "SimplePingManager"
}

variable "tags" {
  type = map(string)
  default = {
    "email_id" = "mishalshah92@gmail.com"
  }
}
