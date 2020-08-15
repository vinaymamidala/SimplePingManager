# service

variable "service_docker_image_tag" {
  type    = string
  default = "latest"
}

variable "service_service_port" {
  type    = number
  default = 8080
}

variable "service_max_instances" {
  type    = number
  default = 5
}

variable "service_min_instances" {
  type    = number
  default = 1
}

variable "service_desired_instances" {
  type    = number
  default = 1
}

variable "service_healthcheck_response_code" {
  type    = number
  default = 200
}

variable "service_healthcheck_path" {
  type    = string
  default = "/"
}