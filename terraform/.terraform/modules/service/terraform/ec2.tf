resource "aws_security_group" "ec2_sg" {
  name        = "${local.name_prefix}-ec2"
  description = "Security group for ec2 machine of Service."
  vpc_id      = var.vpc_id

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  tags = local.tags
}