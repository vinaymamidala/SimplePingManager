# Common

variable "vpc_id" {
  description = "VPC id where to put ec2 machine"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet."
  type        = list(string)
}


# Service

variable "service_version" {
  description = "Version of Launch Template to be deployed."
  type        = string
  default     = "$Latest"
}

variable "service_port" {
  description = "TCP port on which service is running."
  type        = string
  default     = 80
}

variable "service_docker_compose_content" {
  description = "String content of docker-compose file."
  type        = string
}

# Launch Template

variable "ec2_keypair_name" {
  description = "Name of the ec2 key-pair. This will allow you to access your service instance. Default: null"
  type        = string
  default     = null
}

variable "ec2_iam_policy_json" {
  description = "IAM policy that allows ec2 machine to access the ec2 services. Default: null"
  type        = string
  default     = null
}

variable "ec2_ami_id" {
  description = "AMI id that will use to host the EC2 machine."
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "ec2_instance_root_volume_size" {
  description = "Root volume size in GB of EC2 machine. Default: 35"
  type        = number
  default     = 35
}

variable "ec2_public" {
  description = "Define instance is public or private. Default: false"
  type        = bool
  default     = false
}

# ASG

variable "asg_desired_capacity" {
  description = "Desired or default capacity for Auto-Scaling Group. Default: 1"
  type        = number
  default     = 1
}

variable "asg_min_size" {
  description = "Min number of EC2 instance running by Auto-Scaling Group. Default: 1"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Max number of EC2 instance running by Auto-Scaling Group. Default: 3"
  type        = number
  default     = 3
}

variable "asg_cooldown" {
  description = "Min number of EC2 instance running by Auto-Scaling Group. Default: 1"
  type        = number
  default     = 60
}

variable "asg_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health. Default: 30"
  type        = number
  default     = 30
}


# TargetGroup

variable "tg_stickiness_enabled" {
  description = "True if you want to enable sticky session. Default: false"
  type        = bool
  default     = false
}

variable "tg_slow_start" {
  description = "The amount time for targets to warm up before the load balancer sends them a full share of requests. The range is 30-900 seconds or 0 to disable. The default value is 30 seconds"
  type        = number
  default     = 30
}

variable "tg_healthcheck_interval" {
  description = "Interval time in seconds in between, helthcehck requests."
  type        = number
  default     = 5
}

variable "tg_healthcheck_path" {
  description = "Helthcehck path."
  type        = string
  default     = "/"
}

variable "tg_healthcheck_timeout" {
  description = "Healthcehck request timeout in seconds."
  type        = number
  default     = 2
}

variable "tg_healthcheck_healthy_threshold" {
  description = "Number if healthy threasolds before putting instance into service."
  type        = number
  default     = 3
}

variable "tg_healthcheck_unhealthy_threshold" {
  description = "Number if unhealthy threasolds."
  type        = number
  default     = 10
}

variable "tg_healthcheck_response_code" {
  description = "HTTP/HTTPS response code for health-check verification."
  type        = number
  default     = 200
}


# Tags

variable "tags" {
  description = "Map of tags"
  type        = map(string)
  default     = {}
}

variable "owner" {
  description = "Owner of the service."
  type        = string
}

variable "service" {
  description = "Name of the service."
  type        = string
}

variable "env" {
  description = "Name of your environment or stack."
  type        = string
}

variable "commit" {
  description = "Git SHA of the repository with deployment code"
  type        = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}
