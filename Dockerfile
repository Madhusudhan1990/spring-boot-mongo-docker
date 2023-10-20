FROM maven:3.6.1-jdk-8-alpine as madhu
# as madhu is one alias name, we will use that for referring tomcat image
WORKDIR /app
COPY . .
RUN mvn clean package

FROM openjdk:8-alpine

# Required for starting application up.
RUN apk update && apk add /bin/sh

RUN mkdir -p /opt/app
ENV PROJECT_HOME /opt/app

COPY --from=madhu target/spring-boot-mongo-1.0.jar $PROJECT_HOME/spring-boot-mongo.jar

WORKDIR $PROJECT_HOME
EXPOSE 8080
CMD ["java" ,"-jar","./spring-boot-mongo.jar"]
