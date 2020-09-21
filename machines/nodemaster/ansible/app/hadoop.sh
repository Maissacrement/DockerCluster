#!/bin/bash
HADOOP_VERSION=3.3.0
HADOOP=hadoop-${HADOOP_VERSION}

function dowload_hadoop() {
    wget -O ${HADOOP} https://downloads.apache.org/hadoop/common/${HADOOP}/${HADOOP}.tar.gz
}