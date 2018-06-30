# Ping Manager

## Introduction

This is the Ping Manager Service.

## Building

First ensure your development environment is up-to-date. You will need to
install gradle 3.3+ on macOS, Linux and Windows.

Next clone this repository and run make:

    $ make
    
    Note: This build is a java application.
    
To build the dokcer image run:
    
     $ make docker
    
Application jar available on below path
 
    taget/ping-manager.jar
    
To run the jar file, run below command.
    
    java -jar ping-manager.jar

Access application on

    http://[ip]:8080/
