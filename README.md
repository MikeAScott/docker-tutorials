# Learning Docker 
Create and use simple docker containers.

The link on the headings wil take you to the branch or tag for the lab.

For official docker information goto https://docs.docker.com/ 

In particular the [Get Started Guide](https://docs.docker.com/get-started/) is really good.

# [LAB-01](../../tree/LAB-01) - Set up docker in Virtualbox
## Setup Docker
* Install Virtualbox 
* Install Vagrant
* Have a look at the Vagrant file
    * The provisioner sets up docker in Centos/7
* Run vagrant
```
vagrant up
```
* ssh to docker box
```
vagrant ssh docker
docker ps
```
If you get an empty list docker is working :)

## Run containers
### Run hello world
```
docker run hello-world
```
It will download the hello world image and run it.

If you see 'Hello from Docker!' it has worked
### Run centos 
```
docker run -it centos:7 /bin/bash
# This runs an interactive terminal in a centos/7 container
# When in the container run this to show OS details 
cat /etc/os-release
```
Have a play in the container including creating some files
```
# e.g:
touch text.txt
ls
# then exit
exit
```
Now 'rerun' the container
```
docker run -it centos:7 /bin/bash
ls 
# where did your test.txt file go?
exit
```

# [LAB-02](../../tree/LAB-02) - Build and run tomcat container
Steps:
* SSH into docker virtual box
* Change into /vagrant directory
* Look at [Dockerfile](./Dockerfile)
* Build image using the Dockerfile
* Run image detached
* Check tomcat is serving content
* Stop container 

```
# build image
docker image build -t <imagetag> .
# run container detached mapping port 8080 to localhost
docker container run -d -p 8080:8080 <imagetag>
# check content is being served
curl localhost:8080
# Find running container id or name
docker ps
# You shold see a container with your image name running
# stop container
docker stop <image id>
```
### e.g:
```
vagrant ssh docker
cd /vagrant
docker image build -t ms-tomcat .
docker container run -d -p 8080:8080 ms-tomcat
curl localhost:8080
docker ps
docker stop 7b41c6ba2c36
```

# [LAB-03](../../tree/LAB-03) - Build and run mysql container with persistent volume
* Look at [mysql/Dockerfile](mysql/Dockerfile)
* Look at [tomcat/Dockerfile](tomcat/Dockerfile)
Steps:
* SSH into docker virtual box
* Build images using the Dockerfiles
* Create network and volume
* Run images detached
* Check tomcat is serving content
* Check if db server is running
* Stop containers
* Remove containers, network and volume

### e.g:
```
ROOT_PASSWORD=<secret>
DB_PASSWORD=<secret>
vagrant ssh docker

# build images
docker image build -t ms-tomcat /vagrant/tomcat 
docker image build -t ms-mysql /vagrant/mysql \ 
    --build-arg db_root_password=$ROOT_PASSWORD \
    --build-arg db_password=$DB_PASSWORD

# provision network, volume, and containers
docker network create webstack
docker volume create mysql-data
docker container run -d -p 8080:8080 --network webstack --name web ms-tomcat
docker container run -d --volume mysql-data:/var/lib/mysql --network webstack --name db ms-mysql

# check its all running
docker ps
curl localhost:8080

docker exec -it db /bin/bash
# mysql -uroot -p<>secret>
# mysql> show databases;
# you should see tododb in the list
# mysql> exit
# exit


# Stop and tear down
docker container stop web db
docker container rm web db
docker volume rm mysql-data
docker network rm webstack
```

---
Free to use under [MIT Licence](./LICENCE)

Copyright (c) Mike Scott 2020
