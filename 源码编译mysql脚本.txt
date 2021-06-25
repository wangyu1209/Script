#!/bin/bash
yum remove  -y mysql mysql-server
clear
echo 'This shell will Auto Install Mysql5.6'
yum install -y cmake ncurses-devel
tar -xf mysql-5.6.26.tar.gz  -C  /usr/local/src && cd /usr/local/src/mysql-5.6.26
useradd -M -s /sbin/nologin mysql
mkdir /usr/local/mysql
cmake \
 -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
 -DMYSQL_UNIX_ADDR=/tmp/mysql.sock \
 -DDEFAULT_CHARSET=utf8 \
 -DDEFAULT_COLLATION=utf8_general_ci \
 -DWITH_EXTRA_CHARSETS=all \
 -DWITH_MYISAM_STORAGE_ENGINE=1\
 -DWITH_INNOBASE_STORAGE_ENGINE=1\
 -DWITH_MEMORY_STORAGE_ENGINE=1\
 -DWITH_READLINE=1\
 -DENABLED_LOCAL_INFILE=1\
 -DMYSQL_DATADIR=/usr/local/mysql/data \
 -DMYSQL-USER=mysql
make -j 3 && make  install
chown -R mysql:mysql  /usr/local/mysql
/usr/local/mysql/scripts/mysql_install_db --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
mv /etc/my.cnf  /etc/my.cnf.bak
cp -r /usr/local/mysql/support-file/my-default.cnf  /etc/my.cnf
sed -i '/^\[mysqld\]/adatadir = /usr/local/mysql/data' /etc/my.cnf
sed -i '/^\[mysqld\]/abasedir = /usr/local/mysql' /etc/my.cnf
cp -r /usr/local/mysql/support-files/mysql.server  /etc/init.d/mysqld
chmod  +x /etc/init.d/mysqld
echo "PATH=/usr/local/mysql/bin:$PATH" >>/etc/profile
service mysqld restart
echo
echo "install success"
source /etc/profile
echo "source /etc/profile" >>/etc/rc.local
service mysqld restart
echo "If you now running mysql and others commands,Please running: source /etc/profile"
