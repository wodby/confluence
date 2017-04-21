#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
  set -x
fi

chown daemon:daemon /var/atlassian/confluence

if [[ -n "${JIRA_HOST}" ]]; then
    jre="/usr/lib/jvm/java-8-openjdk-amd64/jre"

    if [[ -z "${JIRA_PORT}" ]]; then
        JIRA_PORT=443
    fi

    url="${JIRA_HOST}:${JIRA_PORT}"
    openssl s_client -connect "${url}"  < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/cert.pem
    "${jre}/bin/keytool" -import -alias jira -trustcacerts -keystore "${jre}/lib/security/cacerts" \
        -file /tmp/cert.pem -storepass changeit -noprompt
    rm /tmp/cert.pem
fi

gosu daemon /docker-entrypoint.sh "${@}"
