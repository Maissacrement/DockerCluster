#!/bin/bash

function main() {
    for ip in $@;
    do
        ssh-copy-id -f root@${ip}
    done
}

main $@
