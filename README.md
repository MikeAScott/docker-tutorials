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

---
Free to use under [MIT Licence](./LICENCE)

Copyright (c) Mike Scott 2020
