FROM openjdk:11.0.5-jre

WORKDIR /usr/src/app/
COPY build/libs/SimplePingManager.jar simple-ping-manager.jar
EXPOSE 8080
CMD ["java", "-jar", "simple-ping-manager.jar"]