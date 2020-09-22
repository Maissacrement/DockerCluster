# Ansible deploy config on Docker Image

## Issue


## HOW TO MANAGE

### Master

### RUN Docker Image

cmd: `docker-compose build --build-arg passwd=helloworld`

cmd: `docker-compose up`

### Remote ssh

cmd: `make ssh`

cmd: `ssh root@172.16.x.x`

### Link ssh slaves on master

master: `/APP/linux/ssh_copy.sh $(cat /APP/iplist)` in bash history

### Playbook

nodemaster shared her repo "nodemaster" in /APP all file update is directly in bounded directory

cmd: `ansible-playbook -i /APP/ansible/inventory/host /APP/ansible/playbook/playbook.yml`


![see pdf diagram](./diagramme.pdf "see pdf")
