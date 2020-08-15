#!/bin/sh

set -e

INSTANCE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
export LOCAL_IP=$INSTANCE_IP

echo "INFO: Executing now docker-compose."
{
  aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${AWS_ECR_URL}
  docker-compose -f ${docker_compose_file_path} up -d
  echo "INFO: Executing of docker-compose is complete."

}||{
  echo "INFO: Execution of docker-compose is failed."
  exit 1
}