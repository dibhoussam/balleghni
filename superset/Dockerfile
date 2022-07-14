ARG SUPERSET_VERSION=1.4.2

FROM apache/superset:${SUPERSET_VERSION}

USER root

RUN apt-get update && apt-get install -y netcat

ENV FLASK_ENV ${FLASK_ENV}
ENV SUPERSET_ENV ${SUPERSET_ENV}
ENV SUPERSET_PORT ${SUPERSET_PORT}
ENV PYTHONPATH ${PYTHONPATH}

COPY ./imports /app/docker/imports

COPY ./pythonpath_dev /app/docker/pythonpath_dev

COPY ./docker-bootstrap.sh /app/docker/

COPY ./docker-init.sh /app/docker/

COPY ./run-server.sh /app/docker/