FROM anapsix/alpine-java:8_server-jre

ENV CONF_HOME /var/atlassian/confluence
ENV CONF_INSTALL /opt/atlassian/confluence
ENV CONF_VERSION 6.1.3

ENV CONF_DOWNLOAD_URL https://www.atlassian.com/software/confluence/downloads/binary/atlassian-confluence-${CONF_VERSION}.tar.gz

ENV JAVA_CACERTS $JAVA_HOME/jre/lib/security/cacerts
ENV CERTIFICATE $CONF_HOME/certificate

RUN set -ex && \
    apk add --update bash curl openssl make su-exec tar && \
    mkdir -p "${CONF_HOME}" && chmod -R 700 "${CONF_HOME}" && \
    chown daemon:daemon "${CONF_HOME}" && mkdir -p "${CONF_INSTALL}/conf" && \
    curl -Ls "${CONF_DOWNLOAD_URL}" | tar -xz --directory "${CONF_INSTALL}" --strip-components=1 --no-same-owner && \
    cd ${CONF_INSTALL} && chmod -R 700 conf temp logs work && chown -R daemon:daemon conf temp logs work && \
    echo -e "\nconfluence.home=$CONF_HOME" >> "${CONF_INSTALL}/confluence/WEB-INF/classes/confluence-init.properties" && \
    chown daemon:daemon "${JAVA_CACERTS}"

EXPOSE 8090

VOLUME ["/var/atlassian/confluence", "/opt/atlassian/confluence/logs"]

WORKDIR /var/atlassian/confluence

COPY server.xml /opt/atlassian/confluence/conf/
COPY docker-entrypoint.sh /
COPY actions /usr/local/bin/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/opt/atlassian/confluence/bin/catalina.sh", "run"]