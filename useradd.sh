#!/bin/bash   #执行此脚本时需要确保安装mkpasswd命令，如没有安装则使用yum -y install expect安装，安装完成后执行脚本即可
for u in `seq -w 0 09`
do
 useradd user_$u
 p=`mkpasswd -s 0 -l 10`
 echo $p|passwd --stdin user_$u
 echo -e "$p\n$p"|passwd user_$u
 echo "user_$u $p" >> /tmp/userpassword
done
