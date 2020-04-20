FROM centos:7

RUN yum update -y && \
    yum install http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm -y  && \
    yum install mysql-server -y && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN /usr/bin/mysql-systemd-start pre

ARG db_root_password
COPY secure_installation.sql secure_installation.sql
RUN eval "/usr/bin/mysqld_safe &" && \
    /usr/bin/mysql-systemd-start post && \
    mysql --user=root -e" \
        set @root_pass='${db_root_password}'; \
        source secure_installation.sql ; \
    " && \
    /usr/bin/mysqladmin -uroot --password=${db_root_password} shutdown 

EXPOSE 3306

USER mysql
CMD /usr/bin/mysqld_safe
