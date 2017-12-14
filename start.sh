#!/bin/bash

# Kill all processes when script exits
intexit() {
    # Kill all subprocesses (all processes in the current process group)
    kill -HUP -$$
}

hupexit() {
    # HUP'd (probably by intexit)
    echo
    echo "Interrupted"
    docker-compose stop
    exit
}

trap hupexit HUP
trap intexit INT

# Start mariadb
docker-compose up -d

# Start forward for mysql socket
sudo socat UNIX-LISTEN:/var/run/mysqld/mysqld.sock,fork,\
reuseaddr,unlink-early,user=mysql,group=mysql,mode=777 \
TCP:localhost:3306

wait
