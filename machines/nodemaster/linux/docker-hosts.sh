#!/bin/bash
alias machine=0.0.0.0

function main() {
    docker_machine=$1

    docker exec ${docker_machine} ifconfig | grep inet | awk '{print $2}' > ${PWD}/hosts
    machine=`cat ./hosts | head -1`
    echo ${machine}
}

function onClose() {
    echo "Exit"
}

trap onClose EXIT
main $1
