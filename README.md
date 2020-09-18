# Ansible deploy config on Docker Image

## Issue

Makefile: ${DOCKER_MACHINE_IP} is static 

## HOW TO MANAGE

### Master

### RUN Docker Image

cmd: `docker-compose build --build passwd=helloworld`
cmd: `docker-compose up`

### Remote ssh

cmd: `make ssh`
cmd: `ssh root@172.16.x.x`


![some discription](diagramme.pdf "some discription")




