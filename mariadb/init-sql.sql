# master
SELECT NOW();

grant replication slave on *.* to 'repl'@'%' identified by 'root1234!@';

show master status;
-- mysql-bin.000001,512


# slave
SELECT NOW();

CHANGE MASTER TO MASTER_HOST = '192.168.45.208'
    , MASTER_PORT=13306
    , MASTER_USER='repl'
    , MASTER_PASSWORD='root1234!@'
    , MASTER_LOG_FILE='mysql-bin.000001'
    , MASTER_LOG_POS=512
    , MASTER_CONNECT_RETRY=10;

start slave;

show slave status;

# master
create database dev_base;

create user 'dev_base'@'%' identified by 'base1234!@';
grant all privileges on dev_base.* to 'dev_base'@'%';
flush privileges;