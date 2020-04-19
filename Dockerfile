FROM centos:7

RUN yum install tomcat -y

# RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
# rm -f /lib/systemd/system/multi-user.target.wants/*;\
# rm -f /etc/systemd/system/*.wants/*;\
# rm -f /lib/systemd/system/local-fs.target.wants/*; \
# rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
# rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
# rm -f /lib/systemd/system/basic.target.wants/*;\
# rm -f /lib/systemd/system/anaconda.target.wants/*;

EXPOSE 8080

ENV CATALINA_HOME /usr/share/tomcat
ENV PATH $CATALINA_HOME/bin: $PATH

RUN mkdir -p "$CATALINA_HOME/webapps/ROOT"
COPY files/index.html $CATALINA_HOME/webapps/ROOT/index.html

CMD /usr/libexec/tomcat/server start