FROM azul/zulu-openjdk-alpine:11.0.20

WORKDIR /app

COPY . .

EXPOSE 8082

ADD . app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
