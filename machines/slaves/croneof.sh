#!/bin/sh

export EDITOR=nano
crontab -e << EOF
    #minute hour date month  day of week  CMD
    1        *    *     *         *       echo 'data' >> /tmp/socket/listener
EOF
