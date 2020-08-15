# Terraform EC2 Service Module

This module deploys containerise service on EC2 machine with below and other more capabilities.

- [ASG](https://docs.aws.amazon.com/autoscaling/ec2/userguide/AutoScalingGroup.html) 
- [TargetGroup](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)
- [LauchTempalte](https://docs.aws.amazon.com/autoscaling/ec2/userguide/LaunchTemplates.html) 
- [IAM](https://aws.amazon.com/iam/)
  
  
# Development

**Terraform version**: >= `0.12`

### Example

```hcl-terraform

provider "aws" {
  region = "us-west-2"
}

terraform {
  required_version = ">= 0.12.0"
}

module "service" {
  source = "git::https://github.com/mishah92/terraform-ec2-service-module.git//terraform"
  
  vpc_id    = "vpc-example"
  vpc_subne_ids = [ "subnet-example" ]
  
  # Service
  service_docker_compose_content = "Test content"
  
  # Launch Template
  ec2_ssh_public_key = "public-key-content"
  ec2_iam_policy_json = "{}"
  ec2_ami_id = "centos"
  ec2_instance_type = "t2.medium"
  
  # Tags
  domain  = "example"
  service = "jenkins"
  env     = "test"
  commit  = "no_commit"

}
```
For more info on variables, check [here](terraform/variables.tf)

### Overview

- **Maintainer**: mishalshah92@gmail.com
