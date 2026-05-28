# syntax=docker/dockerfile:1

# ---- Build stage: Java 8 JDK to compile the Spring Boot 1.4.1 WAR ----
FROM eclipse-temurin:8-jdk-jammy AS build
WORKDIR /app

# Copy the wrapper first so the Gradle 3.5.1 download is cached as its own layer
COPY gradle/wrapper gradle/wrapper
COPY gradlew ./
RUN chmod +x gradlew

# Build files + sources
COPY settings.gradle build.gradle ./
COPY libs libs
COPY src src

# Produce the executable Spring Boot WAR at build/libs/plt-0.0.1-SNAPSHOT.war
RUN ./gradlew bootRepackage --no-daemon

# ---- Runtime stage: small Java 8 JRE image ----
FROM eclipse-temurin:8-jre-jammy
WORKDIR /app
COPY --from=build /app/build/libs/plt-0.0.1-SNAPSHOT.war app.war

ENV SERVER_PORT=10000
EXPOSE 10000

ENTRYPOINT ["java", "-jar", "/app/app.war"]
