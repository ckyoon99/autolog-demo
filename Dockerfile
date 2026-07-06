# 1단계: Maven 빌드
FROM maven:3.8-eclipse-temurin-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn -B package -DskipTests

# 2단계: 실행
FROM eclipse-temurin:8-jre
WORKDIR /app

COPY --from=build /app/target/autolog-demo-1.0.0.jar ./app.jar
# JSP 렌더링 — TomcatConfig가 src/main/webapp 경로 참조
COPY --from=build /app/src/main/webapp ./src/main/webapp

ENV PORT=8080
EXPOSE 8080

CMD ["sh", "-c", "java -jar app.jar --server.port=${PORT}"]
