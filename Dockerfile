FROM adoptopenjdk/openjdk12-openj9:jdk-12.0.2_10_openj9-0.15.1-alpine-slim

RUN mkdir -p /data/service/bin /data/service/config
COPY ./kpdi-api/target/promoting-docker-images-*.jar /data/service/bin/service.jar
COPY ./kpdi-api/src/resources/* /data/service/config

CMD java -jar /data/service/bin/service.jar --spring.config.additional-location=/data/service/config/

