terraform {
  # The latest version of Terragrunt (v0.19.0 and above) requires Terraform 0.12.0 or above.
  required_version = "> 0.12"
}

locals {
  name_prefix = "${var.owner}-${var.env}-${var.service}"
  path_prefix = "/${var.owner}/${var.service}/${var.env}/${data.aws_region.current.name}/"

  default_tags = {
    Owner   = var.owner
    Service = var.service
    Env     = var.env
    Commit  = var.commit
    Tool    = var.tool
  }
  tags = merge(local.default_tags, var.tags)
}

