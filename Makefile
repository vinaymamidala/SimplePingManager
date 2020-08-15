REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
COMMIT:=$(DATE)-$(REV)
IMAGE_NAME:=mishalshah92/simple-ping-manager
MODULE:=terraform


build:
	./gradlew clean build

publish:
	docker push $(IMAGE_NAME):latest
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(REV)
	docker push $(IMAGE_NAME):$(REV)

init:
	terraform init $(MODULE)

validate: init
	terraform validate $(MODULE)

plan: validate
	terraform plan -state=$(MODULE)/terraform.tfstate -var 'git_commit=$(COMMIT)' -out=$(COMMIT).tfplan $(MODULE)

deploy: plan
	terraform apply -state=$(MODULE)/terraform.tfstate --auto-approve $(COMMIT).tfplan

destroy: validate
	terraform destroy -state=$(MODULE)/terraform.tfstat -var 'git_commit=$(COMMIT)' --auto-approve $(MODULE)

clean:
	rm -rf .terraform/ || true
	rm plan.out  || true