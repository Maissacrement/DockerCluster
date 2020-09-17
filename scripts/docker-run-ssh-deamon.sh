#!/bin/bash

export DOCKER_MACHINE=`docker ps -aqf "ancestor=slave_node"`

if [ -z $(DOCKER_MACHINE) ];then
    docker-compose ps -q slaves class1 class2 class3  > ./containers 
else
    ${DOCKER_MACHINE} > ./containers
fi

machines=$(cat ./containers)

echo -e $machines

function main() {
    for machine in ${machines}
    do
        docker exec ${machine} /etc/init.d/ssh start
        echo "REMOTE IP ADDR:"
        docker exec ${machine} ifconfig eth0 | awk -e '/inet/ {print $2}'
    done
}

main