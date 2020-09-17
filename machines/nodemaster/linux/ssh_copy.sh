#!/bin/bash

function main() {
    for ip in $@;
    do
        ssh-copy-id root@${ip}
    done
}

main $@
