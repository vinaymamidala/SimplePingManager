terraform {
  required_version = "> 0.12"

  backend "s3" {
    bucket         = "easyaws-terraform-state"
    dynamodb_table = "easyaws-terraform-state"
    key            = "terraform-ec2-service-module/test/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}

locals {
  subdomain   = "${var.env}.${var.owner}.sip"
  hostname    = "${local.subdomain}.${var.route_53_zone}"
  name_prefix = "${var.owner}-${var.env}"

  default_tags = {
    Service  = var.service
    Customer = var.owner
    Env      = var.env
    Commit   = var.git_commit
    Tool     = var.tool
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_key_pair" "keypair" {
  key_name   = local.name_prefix
  public_key = file("${path.module}/keypair/key.pub")
}

resource "aws_route53_record" "dns_record" {
  zone_id = data.aws_route53_zone.route53_zone.zone_id
  name    = local.subdomain
  type    = "CNAME"
  ttl     = "5"
  records = [aws_lb.alb.dns_name]
}
