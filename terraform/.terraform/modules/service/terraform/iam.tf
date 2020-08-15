resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${local.name_prefix}-${data.aws_region.current.name}"
  path = local.path_prefix
  role = aws_iam_role.ec2_instance_role.id
}

resource "aws_iam_role" "ec2_instance_role" {
  name               = "${local.name_prefix}-${data.aws_region.current.name}"
  path               = local.path_prefix
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_role_assume_policy.json
}

resource "aws_iam_policy" "ec2_instance_role_policy" {
  name   = "${local.name_prefix}-${data.aws_region.current.name}"
  path   = local.path_prefix
  policy = var.ec2_iam_policy_json == null ? "{}" : var.ec2_iam_policy_json
}

resource "aws_iam_role_policy_attachment" "ec2_role_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = aws_iam_policy.ec2_instance_role_policy.arn
}