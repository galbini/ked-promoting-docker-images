FROM adoptopenjdk/openjdk12-openj9:jdk-12.0.2_10_openj9-0.15.1-alpine-slim

CMD java -jar /data/service/bin/service.jar --spring.config.additional-location=/data/service/config/

