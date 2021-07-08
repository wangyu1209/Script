#!/bin/bash/
echo "This is Yum install script"
cat<<eof
***********
请在以下界面输入yes或no
***********
eof
read -p "请输入是否执行安装配置网络yum源脚本:" yes
if [ $yes == "yes" ];then
	echo "正在执行配置Yum源脚本"
else
	echo "取消操作"
	exit
fi
yum install -y wget
base_repo=CentOS-Base.repo
if [ ! -f /etc/yum.repos.d/CentOS-Base.repo ];then
	echo "没有此文件"
else
mv /etc/yum.repos.d/$base_repo  /etc/yum.repos.d/$base_repo.bak
fi
if [ -f /etc/yum.repos.d/$base_repo.bak ];then
	echo "已备份无需处理"
else
	echo "无需处理没有找到相关备份文件"
fi
ls /etc/yum.repos.d/
wget -O /etc/yum.repos.d/CentOS-Base.repo https://repo.huaweicloud.com/repository/conf/CentOS-7-reg.repo
#拉取国内镜像源
#安装epel源
wget -O /etc/yum.repos.d/epel-7.repo http://mirrors.aliyun.com/repo/epel-7.repo 
yum clean all && yum makecache && yum update -y
