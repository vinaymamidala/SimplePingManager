data "aws_caller_identity" "self" {}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_route53_zone" "route53_zone" {
  name = var.route_53_zone
}