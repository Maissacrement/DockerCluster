# Ansible deploy config on Docker Image

## Issue

Makefile: ${DOCKER_MACHINE_IP} is static 

## HOW TO MANAGE

### Master

### Remote ssh

cmd: `make ssh`

### RUN Docker Image

cmd: `docker-compose build --build passwd=helloworld`
cmd: `docker-compose up`




