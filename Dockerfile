FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/kaddem-0.0.1.jar kaddem-0.0.1.jar


EXPOSE 8089

CMD ["java", "-jar", "kaddem-0.0.1.jar"]