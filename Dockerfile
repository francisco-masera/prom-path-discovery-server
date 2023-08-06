FROM azul/zulu-openjdk-alpine:11.0.20

WORKDIR /app

COPY gradle gradle
COPY build.gradle settings.gradle gradlew ./
COPY src src

RUN ./gradlew build -x test
RUN mkdir -p build/libs && (cd build/libs; jar -xf ../*.jar)

EXPOSE 8082

ARG BUILD=/workspace/app/build/libs
COPY --from=build ${BUILD}/BOOT-INF/lib /app/lib
COPY --from=build ${BUILD}/META-INF /app/META-INF
COPY --from=build ${BUILD}/BOOT-INF/classes /app

ENTRYPOINT ["java","-cp","app:app/lib/*","org.dargor.discovery"]
