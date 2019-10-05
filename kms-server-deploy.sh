#!/usr/bin/env bash
# 开机自启脚本来自秋水大佬,感谢！
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

echo "#============================================================================="
echo "# System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+"
echo "# Description: deploy the vlmcsd server(windows系列的VL版本KMS激活服务端一键搭建)"
echo "# Version: 2.0.0"
echo "# Author:Mrxn"
echo "# Date:05/10/2019"
echo "# Blog:https://mrxn.net"
echo "# kms_server:kms.mrxn.net"
echo "#============================================================================="

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

# 检查系统是否符合&是否已经安装vlmcsd服务
check_root() {
	[[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1
}
check_pid() {
	PID=$(ps -ef | grep -v grep | grep vlmcsd | awk '{print $2}')
	if [ ! -z $PID ]; then
		STAT=0
	else
		STAT=1
	fi
}
check_vlmcsd_start() {
	check_pid
	[[ ! -z ${PID} ]] && echo -e "${Error} vlmcsd正在运行,退出安装程序！" && exit 1
}
check_vlmcsd_stop() {
	check_pid
	[[ -z ${PID} ]] && echo -e "${Tip} 未发现vlmcsd服务,准备安装！"
}
check_vlmcsd_status() {
	check_DAMON_status
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} vlmcsd正在运行,放心玩去吧！" && exit 1
	elif [ $STAT = 1 ]; then
		echo -e "${Tip} 未发现vlmcsd服务,请尝试重启vlmcsd服务端或者是安装vlmcsd服务端"
	fi
}
check_sys() {
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	else
	    release=""
	fi
	bit=$(uname -m)
}
check_root
check_sys
[[ ${release} != "debian" ]] && [[ ${release} != "ubuntu" ]] && [[ ${release} != "centos" ]] && echo -e "${Error} 本脚本不支持当前系统 ${release} !" && exit 1
# Get version
getversion(){
    if [[ -s /etc/redhat-release ]]; then
        grep -oE  "[0-9.]+" /etc/redhat-release
    else
        grep -oE  "[0-9.]+" /etc/issue
    fi
}

# CentOS version
centosversion(){
    if [[ x"${release}" == x"centos" ]]; then
        local code=$1
        local version="$(getversion)"
        local main_ver=${version%%.*}
        if [ "$main_ver" == "$code" ]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}
# 开始安装vlmcsd依赖
install_depend() {
	if [[ ${release} == "centos" ]]; then
		yum install wget gcc git make nss curl libcurl -y
	elif [[ ${release} == "debian" ]] || [[ ${release} == "ubuntu" ]]; then
		apt-get install wget gcc git make libnss3 curl libcurl3-nss -y
	fi
	echo -e "${Info} 依赖安装完毕...开始安装vlmcsd主程序..."

}
check_install_status() {
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} vlmcsd安装成功!"
	elif [ $STAT = 1 ]; then
		echo -e "${Error} vlmcsd安装失败!"
	fi
}
# 开机自启动
auto_start() {
	if [[ x"${release}" == x"centos" ]]; then
        if ! wget --no-check-certificate -O /etc/init.d/kms https://raw.githubusercontent.com/Mr-xn/kms-server-deploy/master/kms; then
            echo -e "${Error} Failed to download KMS Server script."
            exit 1
        fi
    elif [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
        if ! wget --no-check-certificate -O /etc/init.d/kms https://raw.githubusercontent.com/Mr-xn/kms-server-deploy/master/kms-debian; then
            echo -e "${Error} Failed to download KMS Server script."
            exit 1
        fi
    else
        echo -e "${Error} OS is not be supported, please change to CentOS/Debian/Ubuntu and try again."
        exit 1
    fi
}
boot_start(){
    if [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
        update-rc.d -f "${1}" defaults
    elif [[ x"${release}" == x"centos" ]]; then
        chkconfig --add "${1}"
        chkconfig "${1}" on
    fi
}

boot_stop(){
    if [[ x"${release}" == x"debian" || x"${release}" == x"ubuntu" ]]; then
        update-rc.d -f "${1}" remove
    elif [[ x"${release}" == x"centos" ]]; then
        chkconfig "${1}" off
        chkconfig --del "${1}"
    fi
}
# 开始从Wind4的仓库克隆到本地安装
backup_old_vlmcsd() {
	if [[ -f $DAEMON ]]; then
		echo -e "${Tip} 发现旧的vlmcsd文件,将自动备份到/root/vlmcsd目录!"
		mkdir /root/vlmcsd
		mv $DAEMON /root/vlmcsd/old_vlmcsd
	elif [[ ! -f $DAEMON ]]; then
		echo -e "${Tip} 文件不存在,即将安装!"
	fi
}
start_install() {
	[[ -f $DAEMON ]] && echo -e "${Info} vlmcsd已经安装..." && exit 1
	echo -e "${Info} 正在检查当前账号是否有执行权限部署操作..."
	echo -e "${Info} 正在检查是否已经安装vlmcsd..."
	echo -e "${Info} 恭喜,系统检查通过,检查是否安装vlmcsd服务端中..."
	check_vlmcsd_stop
	check_vlmcsd_start
	backup_old_vlmcsd
	echo -e "${Tip}${Red_font_prefix} 检查完毕,开始安装vlmcsd服务端...${Font_color_suffix}"
	echo -e "${Info} 依赖安装/检查中..."
	install_depend
	git clone https://github.com/Wind4/vlmcsd.git
	[ -d vlmcsd ] && cd vlmcsd || echo -e "${Error} Failed to git clone vlmcsd."
	make
	if [ $? -ne 0 ]; then
        echo -e "${Error} 编译KMS 服务端出错,请重试或者将出错信息提交到 https://github.com/Mr-xn/kms-server-deploy/issues."
        exit 1
    fi
	auto_start
	mkdir /usr/local/kms
	cp -p bin/vlmcsd /usr/local/kms/
	chmod 755 /usr/local/kms/vlmcsd
	chmod 755 /etc/init.d/kms
	boot_start kms
    /etc/init.d/kms start
	check_DAMON_status
	Add_iptables
	Save_iptables
	# vlmcsd_start
	check_install_status
}
check_install() {
	echo && stty erase '^H' && read -p "确认安装?[y/n]:" choice
	case $choice in
	"y")
		start_install
		;;
	"n")
		exit 0
		;;
	*)
		echo "Please enter y or n!"
		;;
	esac
}
# 设置 防火墙规则
Add_iptables() {
	if centosversion 7; then
	systemctl status firewalld > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            firewall-cmd --permanent --zone=public --add-port=1688/tcp
            firewall-cmd --reload
        else
			echo -e "${Error} 不存在firewalld 或者firewalld 没有安装，请手动将 1688端口放行."
		fi
	elif centosversion 6 || ${release} == "debian" || ${release} == "ubuntu"; then
		/etc/init.d/iptables status > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            iptables -L -n | grep -i 1688 > /dev/null 2>&1
            if [ $? -ne 0 ]; then
                iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 1688 -j ACCEPT
                /etc/init.d/iptables save
                /etc/init.d/iptables restart
            fi
        else
			echo -e "${Error} iptables 没有启动或没有安装，请手动将 1688端口放行."
		fi
	fi
}
Del_iptables() {
	if centosversion 6 || ${release} == "debian" || ${release} == "ubuntu"; then
		iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport 1688 -j ACCEPT
		/etc/init.d/iptables save
		/etc/init.d/iptables restart
	elif centosversion 7; then
		firewall-cmd --zone=public --remove-port=1688/tcp --permanent
		firewall-cmd --reload
	fi
}
Save_iptables() {
	if centosversion 6 || ${release} == "debian" || ${release} == "ubuntu"; then
		/etc/init.d/iptables save
		/etc/init.d/iptables restart
	elif centosversion 7; then
		firewall-cmd --reload
	fi
}

DAEMON=/usr/local/kms/vlmcsd
STAT=2
check_DAMON_status() {
	[[ ! -f $DAEMON ]] && echo -e "${Error} 文件不存在,请安装!" && exit 1
}
vlmcsd_restart() {
	check_DAMON_status
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} 重启vlmcsd服务端中..."
		kill $PID
	elif [ $STAT = 1 ]; then
		echo -e "${Info} vlmcsd服务端未启动,启动中..."
	fi
	# $DAEMON -L 0.0.0.0:1688 -l vlmcsd.log
	/etc/init.d/kms restart
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} Succeeded."
	elif [ $STAT = 1 ]; then
		echo -e "${Info} Failed."
	fi
}
vlmcsd_stop() {
	check_DAMON_status
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} 停止vlmcsd服务端..."
		kill $PID
		check_pid
		if [ $STAT = 0 ]; then
			echo -e "${Info} Failed."
		elif [ $STAT = 1 ]; then
			echo -e "${Info} Succeeded."
		fi
	elif [ $STAT = 1 ]; then
		echo -e "${Info} vlmcsd没有运行"
	fi
}
vlmcsd_start() {
	check_DAMON_status
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} vlmcsd服务端已经运行."
		exit 0
	elif [ $STAT = 1 ]; then
		echo -e "${Info} vlmcsd服务端未启动,启动中..."
		$DAEMON -L 0.0.0.0:1688 -l vlmcsd.log
	fi
	check_pid
	if [ $STAT = 0 ]; then
		echo -e "${Info} Succeeded."
	elif [ $STAT = 1 ]; then
		echo -e "${Info} Failed."
	fi
}
uninstall_vlmcsd() {
	echo -e "${Tip} 正在卸载vlmcsd服务端..."
	vlmcsd_stop
	rm -rf $DAEMON
	rm -f /etc/init.d/kms
	rm -f /var/log/vlmcsd.log
	echo -e "${Tip} 卸载vlmcsd服务端完毕..."
	Del_iptables
	Save_iptables
	echo -e "${Tip} 删除防火墙规则完毕..."
}
check_uninstall() {
	check_DAMON_status
	echo && stty erase '^H' && read -p "确认卸载?[y/n]:" choice
	case $choice in
	"y")
		uninstall_vlmcsd
		;;
	"n")
		exit 0
		;;
	*)
		echo -e "${Tip} 请输入[y]或者[n]!"
		;;
	esac
}
echo -e "  vlmcsd服务端 一键管理脚本 ${Red_font_prefix}Powered By Mrxn.Net${Font_color_suffix}

  ${Green_font_prefix}1.${Font_color_suffix} 安装vlmcsd服务端
  ${Green_font_prefix}2.${Font_color_suffix} 查看vlmcsd的状态
  ${Green_font_prefix}3.${Font_color_suffix} 启动vlmcsd服务端
  ${Green_font_prefix}4.${Font_color_suffix} 停止vlmcsd服务端
  ${Green_font_prefix}5.${Font_color_suffix} 重启vlmcsd服务端
  ${Green_font_prefix}6.${Font_color_suffix} 卸载vlmcsd服务端
  "

echo && stty erase '^H' && read -p "请输入数字 [1-6]：" num
case "$num" in
1)
	start_install
	;;
2)
	check_vlmcsd_status
	;;
3)
	vlmcsd_start
	;;
4)
	vlmcsd_stop
	;;
5)
	vlmcsd_restart
	;;
6)
	check_uninstall
	;;
*)
	echo -e "${Error} 请输入正确的数字 [1-6]"
	;;
esac
