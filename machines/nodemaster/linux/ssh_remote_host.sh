#!/bin/bash

function ssh_config_machine() {
    docker_machine=$1
    PWDR=${PWD}/machines/nodemaster
    mkdir -p ${PWDR}/key
    chown -R $USER:$USER ${PWDR}/key
    touch ${PWDR}/key/key{,.pub}
    
    echo -e '\nGenerate ssh key\n'
    docker exec ${docker_machine} ssh-keygen -f /root/.ssh/id_rsa -N "" 
    
    echo -e "\nGet private key\n"
    docker exec ${docker_machine} cat /root/.ssh/id_rsa > ${PWDR}/key/key
    chmod -R 600 ${PWDR}/key/key

    echo -e "\nGet pub key\n"
    docker exec ${docker_machine} cat /root/.ssh/id_rsa.pub > ${PWDR}/key/key.pub
    chmod -R 600 ${PWDR}/key/key.pub

    echo -e "\nNetwork conf\n"
    docker exec ${docker_machine} ifconfig | grep inet | awk '{print $2}' > ${PWDR}/hosts
    machine=`cat ${PWDR}/hosts | head -1`

    echo -e "\nSSH Copy on ${machine}\n"
    ssh-keygen -R ${machine}
    ssh-copy-id -i ${PWDR}/key/key.pub -f root@${machine}
}

#function main() {
#    case $2 in
#    docker)
#      ssh_config_machine $1 $(docker exec $1)
#      ;;
#    compose)
#      ssh_config_machine $1 $(docker-compose exec $1)
#      ;;
#    *)
#      echo 'Default exec docker deamon'
#      ssh_config_machine $1 $(docker exec $1)
#      ;;
#    esac
#}

function main() {
    ssh_config_machine $1
}

main $@