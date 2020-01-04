REV:=$(shell git rev-parse --short HEAD)
IMAGE_NAME:=mishalshah92/simple-ping-manager

build:
	./gradlew clean build

publish:
	docker push $(IMAGE_NAME):latest
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(REV)
	docker push $(IMAGE_NAME):$(REV)