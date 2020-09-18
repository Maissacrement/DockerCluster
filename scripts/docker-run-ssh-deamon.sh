#!/bin/bash

export DOCKER_MACHINE=`docker ps -aqf "ancestor=slave_node"`
export DOCKER_MASTER=`docker ps -aqf "ancestor=nodemaster"`

if [ -z $(DOCKER_MASTER) ];then
    export DOCKER_MASTER=`docker-compose ps -q nodemaster`
fi

if [ -z $(DOCKER_MACHINE) ];then
    docker-compose ps -q slaves class1 class2 class3  > ./containers 
else
    ${DOCKER_MACHINE} > ./containers
fi

machines=$(cat ./containers)

echo -e $machines

function main() {
    export IP_LIST=/APP/iplist
    docker exec ${DOCKER_MASTER} rm -f ${IP_LIST} && touch ${IP_LIST}
    for machine in ${machines}
    do
        docker exec ${machine} /etc/init.d/ssh start
        echo "REMOTE IP ADDR:"
         export IP=$(docker exec ${machine} ifconfig eth0 | awk -e '/inet\s([0-9]|.)+/ {print $2}')
        docker exec ${machine} echo ${IP}
        docker exec ${DOCKER_MASTER} /bin/bash -c "echo ${IP} >> ${IP_LIST}"
        #docker exec ${DOCKER_MASTER} /bin/bash -c "/APP/linux/ssh_copy.sh ${IP}"
    done
}

main