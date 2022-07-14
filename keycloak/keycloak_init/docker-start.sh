#!/bin/sh

while !</dev/tcp/kcx_db/5432; do sleep 1; done; \
/opt/keycloak/bin/kc.sh start --auto-build --db=postgres --http-enabled=true --hostname-strict-https=false --http-port=8080 --http-host=0.0.0.0