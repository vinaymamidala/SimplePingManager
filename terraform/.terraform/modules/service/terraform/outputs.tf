output "service_target_group_name" {
  value = aws_lb_target_group.service_lb_tg.name
}

output "service_lc_name" {
  value = aws_launch_template.service_template.name
}

output "service_target_group_arn" {
  value = aws_lb_target_group.service_lb_tg.arn
}

output "service_asg_name" {
  value = aws_autoscaling_group.service_asg.name
}

output "service_instance_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "service_instance_sg_name" {
  value = aws_security_group.ec2_sg.name
}

output "service_instance_role_name" {
  value = aws_iam_role.ec2_instance_role.name
}

output "service_instance_policy_name" {
  value = aws_iam_policy.ec2_instance_role_policy.name
}

output "service_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_instance_profile.name
}