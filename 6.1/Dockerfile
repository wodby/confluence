FROM cptactionhank/atlassian-confluence:6.1.1

USER root

RUN apt-get install gosu

COPY docker-confluence-entrypoint.sh /

ENTRYPOINT ["/docker-confluence-entrypoint.sh"]

CMD ["/opt/atlassian/confluence/bin/catalina.sh", "run"]