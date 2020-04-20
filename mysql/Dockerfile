FROM centos:7

ARG root_password

RUN yum update -y && \
    yum install http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm -y  && \
    yum install mysql-server -y && \
    yum clean all && \
    rm -rf /var/cache/yum

USER mysql
RUN whoami && \
    mysql_install_db -name=mysql && \
    eval "/usr/bin/mysqld_safe &" && \
    sleep 5 && \
    /usr/bin/mysqladmin -u root password ${root_password} && \
    /usr/bin/mysqladmin -u root --password=${root_password} shutdown 

EXPOSE 3306

VOLUME /var/lib/mysql

CMD mysqld