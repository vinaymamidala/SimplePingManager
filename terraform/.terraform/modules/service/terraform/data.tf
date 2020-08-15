data "aws_caller_identity" "current" {
}

data "aws_region" "current" {}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_iam_policy_document" "ec2_instance_role_assume_policy" {
  statement {

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "template_file" "cloud_init" {
  template = file("${path.module}/configs/cloud_init_config.yaml")

  vars = {
    docker_compose_file_base64_content = base64encode(var.service_docker_compose_content)
    docker_compose_file_path           = "docker-compose.yaml"
  }
}

data "template_file" "init_script" {
  template = file("${path.module}/configs/init.sh")

  vars = {
    AWS_REGION               = data.aws_region.current.name
    AWS_ECR_URL              = "${data.aws_caller_identity.current.account_id}.dkr.ecr.${data.aws_region.current.name}.amazonaws.com"
    docker_compose_file_path = "docker-compose.yaml"
  }
}

data "template_cloudinit_config" "ec2_init_config_base64_encode" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.cloud_init.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.init_script.rendered
  }
}
