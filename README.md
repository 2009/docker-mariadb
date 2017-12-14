## Running

Use the following shell script:

```
./start.sh
```

## Create a socket on the host to forward connections

This uses **socat** and allows you to run the `mysql` client and connect
the docker instance without having define any additional params.

```
socat UNIX-LISTEN:/var/run/mysqld/mysqld.sock,fork,\
reuseaddr,unlink-early,user=mysql,group=mysql,mode=777 \
TCP:localhost:3306 &
```
