ARG KCX_VERSION=17.0.0

FROM maven:3.8.4-openjdk-8-slim as builder

COPY searchby-attr /usr/src/app

WORKDIR /usr/src/app/

RUN mvn clean install

FROM quay.io/keycloak/keycloak:${KCX_VERSION}

WORKDIR /opt/keycloak

COPY --from=builder /usr/src/app/target/token-keycloak-api-extensions-1.0-SNAPSHOT.jar /opt/keycloak/providers/token-keycloak-api-extensions-1.0-SNAPSHOT.jar

COPY ./keycloak_init/ /keycloak_init/

EXPOSE 8080

ENTRYPOINT [ "/keycloak_init/docker-start.sh" ]