#!/bin/sh

until [[ "$(/opt/keycloak/bin/kcadm.sh get serverinfo --server http://kcx:8080/auth --realm master 2>&1)" == *"401"* ]] ; do echo "Retrying..."; sleep 5 ; done ;

sed -i 's/#db=postgres/db=postgres/g' /opt/keycloak/conf/keycloak.conf

/opt/keycloak/bin/kc.sh -cf /opt/keycloak/conf/keycloak.conf build

OVERWRITE=false;
if [[ "$(/opt/keycloak/bin/kcadm.sh config credentials --server http://kcx:8080/auth --realm ballighni --user admin --password ballighni-password 2>&1)" == *"Realm does not exist"* ]];
then
	OVERWRITE=true;
fi

/opt/keycloak/bin/kc.sh -cf /opt/keycloak/conf/keycloak.conf import --dir /tmp/import --override $OVERWRITE;