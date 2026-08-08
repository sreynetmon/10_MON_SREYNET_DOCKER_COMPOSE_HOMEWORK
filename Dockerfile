
FROM gradle:9.5.1-jdk21 AS builder

WORKDIR /builder

COPY build.gradle .
COPY settings.gradle .
COPY gradle gradle
COPY src src

RUN gradle -x test build --build-cache --no-daemon


FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=builder builder/build/libs/*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]