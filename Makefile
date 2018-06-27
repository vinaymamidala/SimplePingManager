
build:
	mvn clean package docker:build

.PHONY: build

clean:
	rm -rf ./target/

.PHONY: clean
