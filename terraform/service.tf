data "template_file" "service_docker_compose" {
  template = file("${path.module}/configs/service-docker-compose.yml")

  vars = {
    tag  = var.service_docker_image_tag
    port = var.service_service_port
  }
}

data "aws_iam_policy_document" "service" {
  statement {
    sid = "1"

    actions = [
      "ecr:DescribeImageScanFindings",
      "ecr:GetLifecyclePolicyPreview",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:ListTagsForResource",
      "ecr:ListImages",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetRepositoryPolicy",
      "ecr:GetLifecyclePolicy"
    ]

    resources = [
      "arn:aws:ecr:${var.region}:${data.aws_caller_identity.self.account_id}:repository/${var.owner}/dynamic_demand"
    ]
  }
}

module "service" {
  source = "git::https://github.com/mishah92/terraform-ec2-service-module.git//terraform"

  # service
  service_docker_compose_content = data.template_file.service_docker_compose.rendered
  service_port                   = var.service_service_port

  # configurations
  ec2_ami_id                   = var.app_ami_id
  ec2_iam_policy_json          = data.aws_iam_policy_document.service.json
  ec2_instance_type            = var.ec2_instance_type
  ec2_keypair_name             = aws_key_pair.keypair.key_name
  ec2_public                   = true
  asg_max_size                 = var.service_max_instances
  asg_min_size                 = var.service_min_instances
  asg_desired_capacity         = var.service_desired_instances
  tg_healthcheck_response_code = var.service_healthcheck_response_code
  tg_healthcheck_path          = var.service_healthcheck_path

  # network
  vpc_id         = data.aws_vpc.default.id
  vpc_subnet_ids = data.aws_subnet_ids.subnets.ids

  # Tags
  owner   = var.owner
  service = var.service
  env     = var.env
  commit  = var.git_commit
  tags    = var.tags
}

# Security Group Rules

resource "aws_security_group_rule" "service_service" {
  security_group_id        = module.service.service_instance_sg_id
  type                     = "ingress"
  from_port                = var.service_service_port
  to_port                  = var.service_service_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "service_local_access" {
  security_group_id = module.service.service_instance_sg_id
  type              = "ingress"
  from_port         = 0
  to_port           = 65534
  protocol          = "tcp"
  cidr_blocks = [
    var.private_cidr
  ]
}

# ALB Scaling Policy
resource "aws_autoscaling_policy" "service_service_scaling_policy" {
  name                      = "${local.name_prefix}-dynamic-backend-scale-out"
  autoscaling_group_name    = module.service.service_asg_name
  metric_aggregation_type   = "Average"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = "60"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 80.0
  }
}