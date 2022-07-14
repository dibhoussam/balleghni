ARG KCX_VERSION=17.0.0

FROM quay.io/keycloak/keycloak:${KCX_VERSION}

WORKDIR /opt/keycloak

COPY ./docker-*.sh /keycloak_init/

COPY ./realms/ /tmp/import/

ENTRYPOINT [ "/keycloak_init/docker-init.sh" ]