FROM centos:7

RUN yum install tomcat -y  && \
    yum clean all && \
    rm -rf /var/cache/yum

EXPOSE 8080

ENV CATALINA_HOME /usr/share/tomcat
ENV PATH $CATALINA_HOME/bin: $PATH

RUN mkdir -p "$CATALINA_HOME/webapps/ROOT"
COPY files/index.html $CATALINA_HOME/webapps/ROOT/index.html

CMD /usr/libexec/tomcat/server start