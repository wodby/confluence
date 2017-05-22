#!/usr/bin/env bash

set -e

if [[ -n "${DEBUG}" ]]; then
    set -x
fi

if [[ "${1}" == 'make' ]]; then
    su-exec daemon "${@}" -f /usr/local/bin/actions.mk
else
    chown daemon:daemon /var/atlassian/confluence

    if [[ -n "${JIRA_HOST}" ]]; then
        if [[ -z "${JIRA_PORT}" ]]; then
            JIRA_PORT=443
        fi

        url="${JIRA_HOST}:${JIRA_PORT}"
        openssl s_client -connect "${url}"  < /dev/null | sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' > /tmp/cert.pem
        "${JAVA_HOME}/bin/keytool" -import -alias jira -trustcacerts -keystore "${JAVA_HOME}/lib/security/cacerts" \
            -file /tmp/cert.pem -storepass changeit -noprompt
        rm /tmp/cert.pem
    fi

    su-exec daemon "${@}"
fi
