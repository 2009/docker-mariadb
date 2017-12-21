# MariaDB docker setup w/ host socket support

* Uses `./mysql` on the host to store database files and allow access
* Create `/var/run/mysqld/mysqld.socket` to allow the host to connect to mysql on the
container using mysql clients on the host.

## Running

Use the following shell script:

```
./start.sh
```

## Create a socket on the host to forward connections (what start.sh does)

This uses **socat** and allows you to run the `mysql` client and connect
the docker instance without having define any additional params.

```
socat UNIX-LISTEN:/var/run/mysqld/mysqld.sock,fork,\
reuseaddr,unlink-early,user=mysql,group=mysql,mode=777 \
TCP:localhost:3306 &
```
