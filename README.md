# SimplePingManager 

![](https://github.com/mishalshah92/SimplePingManager/workflows/java-ci/badge.svg)

## Introduction

This is the Simple Ping Manager Service. A small project that can help to health-check of any URL.
Just enter your URL and IP address and wait for the response.

## Building

First ensure your development environment is up-to-date. You will need to install gradle 6.0+ on macOS, Linux.

```shell script
    $ make [Target]
```

- `$ make build`

This target compile the java project and build the docker image. 
    
- `$ make publish`

This target publish the docker image to [DockerHub](https://hub.docker.com/repository/docker/mishalshah92/simple-ping-manager)


## Run

To run the JAR file generated on path <build/libs/SimplePingManager.jar>

```shell script
    java -jar simple-ping-manager.jar
``` 

To run the docker image

```shell script
    docker run -p 8080:8080 mishalshah92/simple-ping-manager:latest
``` 

Access application on

```shell script
    http://localhost:8080/
``` 

## Artifacts

- **Docker Image**: <https://hub.docker.com/repository/docker/mishalshah92/simple-ping-manager>

