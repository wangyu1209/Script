#!/bin/bash
for u in `seq -w 0 09`
do
 useradd user_$u
 p=`mkpasswd -s 0 -l 10`
 echo $p|passwd --stdin user_$u
 echo -e "$p\n$p"|passwd user_$u
 echo "user_$u $p" >> /tmp/userpassword
done
