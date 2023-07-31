FROM mcr.microsoft.com/openjdk/jdk:17-mariner
VOLUME /tmp
ARG EXTRACTED=./target/extracted
COPY ${EXTRACTED}/dependencies/ ./
COPY ${EXTRACTED}/spring-boot-loader/ ./
COPY ${EXTRACTED}/snapshot-dependencies/ ./
COPY ${EXTRACTED}/application/ ./
ENV SERVER_PORT=1025
ENTRYPOINT ["java","org.springframework.boot.loader.JarLauncher"]
