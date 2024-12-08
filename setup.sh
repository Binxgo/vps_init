#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "请以 root 用户运行"
  exit
fi



function update_upgrade() {

	echo "开始更新并升级软件包..."
	apt-get update && apt-get upgrade
	echo "完成更新并升级软件包"
}


function modify_timezone() {
    echo "修改系统时区为 Asia/Shanghai..."
    timedatectl set-timezone Asia/Shanghai
    echo "系统时区已修改为 Asia/Shanghai"
}

function install_bbr() {
    # 开启 bbr
	echo "开始启用 bbr..."
	bash -c 'echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf'
	bash -c 'echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf'
	sysctl -p
 	sysctl net.ipv4.tcp_available_congestion_control 
	lsmod | grep bbr
	echo "完成启用 bbr"
}

function install_rclone() {
	# 安装 Rclone
	echo "开始安装 Rclone..."
	sudo -v ; curl https://rclone.org/install.sh | sudo bash
	apt-get install fuse3 -y
	echo "完成安装 Rclone"
}

function install_curl() {

	# 安装 curl 
	echo "开始安装 curl "
	apt-get install -y curl
	echo "完成安装 curl "
}


function install_docker() {
	# 安装 docker
	echo "开始安装 docker..."
	curl -fsSL https://get.docker.com | bash 
	echo "完成安装 docker"
}

function install_docker-compose() {
    echo "开始安装 docker-compose..."
    COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep 'tag_name' | cut -d\" -f4)
    curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod a+x /usr/local/bin/docker-compose 
    echo "完成安装 docker-compose"
}

function install_python() {
	# 安装 Python 3 和 pip
	echo "开始安装 Python 3 和 pip..."
	apt-get install -y python3 python3-pip
	echo "完成安装 Python 3 和 pip"
}

function install_screen() {
	# 安装 Screen
	echo "开始安装 Screen..."
	apt-get install screen -y
	echo "完成安装 Screen"
}

function install_fail2ban() {
	# 安装 fail2ban
	echo "开始安装 fail2ban..."
	apt-get install fail2ban -y
	echo "完成安装 fail2ban"
}

function install_ecs() {
	# 融合怪测试脚本
	echo "开始融合怪测试脚本..."
	bash <(wget -qO- bash.spiritlhl.net/ecs)
	echo "完成融合怪测试脚本"
}

function install_swap() {
	# 安装swap
	echo "开始安装swap..."
	bash <(curl -Ls https://www.moerats.com/usr/shell/swap.sh)
	echo "完成安装swap"

}



function adduser_addsudo() {
	# 添加用户并加入sudo组 
	echo "开始添加用户并加入sudo组..."
	adduser eric && apt-get install sudo && usermod -aG sudo eric && echo "eric  ALL=(ALL) NOPASSWD:ALL" | tee /etc/sudoers.d/eric 
	echo "完成添加用户并加入sudo组"

}


function install_lsb-release() {
	# 安装lsb-release
	echo "开始安装lsb-release..."
	apt-get install -y lsb-release
	echo "完成安装lsb-release"

}

function install_wget() {
	# 安装wget
	echo "开始安装wget..."
	apt-get install -y wget 
	echo "完成安装wget"

}


while true; do
    echo "VPS初始化安装软件包："
    echo "1.  更新系统并升级软件包"
    echo "2.  修改系统时区为 Asia/Shanghai"
    echo "3.  开起BBR"
    echo "4.  安装 Rclone"
    echo "5.  安装 docker"
    echo "6.  安装 docker-compose"
    echo "7.  安装 Python 3 和 pip"
    echo "8.  安装 Screen"
    echo "9.  安装 fail2ban"
    echo "10. 安装 融合怪测试脚本"
    echo "11. 安装 swap"
    echo "12. 添加用户并加入sudo组"
    echo "13. 安装 lsb-release"
    echo "14. 安装 wget"
    echo "-------------"
    echo "0. 退出"

    read -p "请选择一个选项：" choice

    case $choice in
        1)
            update_upgrade
            ;;
        2)
            modify_timezone
            ;;
        3)
            install_bbr
            ;;
        4)
            install_rclone
            ;;
        5)
            install_docker
            ;;
        6)
            install_docker-compose
            ;;
        7)
            install_python
            ;;
        8)
            install_screen
            ;;
        9)
            install_fail2ban
            ;;
        10)
            install_ecs
            ;;
        11)
            install_swap
            ;;
		12)
            adduser_addsudo
            ;;

        13)
        	install_lsb-release
        	;;    
        14)
			install_wget
			;;        
        0)
            echo "退出菜单"
            break
            ;;
        *)
            echo "无效的选项，请重新选择"
            ;;
    esac

    echo
done
