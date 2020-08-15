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
  source = "git::https://github.com/pro-works/terraform-ec2-service-module.git//terraform"
  
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

For more info on variables, check [here](variables.tf)
