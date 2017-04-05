FROM cptactionhank/atlassian-confluence:6.1.1

COPY docker-confluence-entrypoint.sh /

USER root

RUN apt-get install gosu

ENTRYPOINT ["/docker-confluence-entrypoint.sh"]

CMD ["/opt/atlassian/confluence/bin/catalina.sh", "run"]