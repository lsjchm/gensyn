#!/bin/bash

# 文本颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # 没有颜色（重置颜色

# 检查是否存在Curl并安装（如果未安装）
if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install curl -y
fi
sleep 1

# 显示徽标
curl -s https://raw.githubusercontent.com/lsjchm/gensyn/refs/heads/main/logo.sh | bash

# 菜单
    echo -e "${YELLOW}选择操作:${NC}"
    echo -e "${CYAN}1) 节点安装${NC}"
    echo -e "${CYAN}2) 更新节点${NC}"
    echo -e "${CYAN}3) 日志查看器${NC}"
    echo -e "${CYAN}4) 删除节点${NC}"

    echo -e "${YELLOW}输入1-4：${NC} "
    read choice

    case $choice in
        1)
            echo -e "${BLUE}安装Gensyn节点...${NC}"

            # 更新和安装依赖关系
            sudo apt-get update && sudo apt-get upgrade -y
            sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev tar clang bsdmainutils ncdu unzip libleveldb-dev  -y

            
            # 检查可用的Docker
            if ! command -v docker &> /dev/null; then
                echo -e "${BLUE}Docker没有安装。安装Docker..${NC}"
                sudo apt update
                sudo apt install docker.io -y
                # 启动docker守护进程，如果它没有运行
                sudo systemctl enable --now docker
            fi
            
            # 检查Docker Compose
            if ! command -v docker-compose &> /dev/null; then
                echo -e "${BLUE}Docker Compose没有安装。安装Docker Compose...${NC}"
                sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
            fi

            sudo usermod -aG docker $USER
            sleep 1
            sudo apt-get install python3 python3-pip python3-venv python3-dev -y
            sleep 1
            sudo apt-get update
            curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
            sudo apt-get install -y nodejs
            node -v
            sudo npm install -g yarn
            yarn -v

            curl -o- -L https://yarnpkg.com/install.sh | bash
            export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
            source ~/.bashrc

            cd
            git clone https://github.com/lsjchm/rl-swarm/

            cd $HOME/rl-swarm/modal-login
            npm install viem@2.22.6
            cd

            echo -e "${RED}返回文本指南并按照以下说明进行操作！${NC}"
            ;;

        2)
            echo -e "${BLUE}转到文本指南并按照更新部分中的说明进行操作！${NC}"
            ;;

        3)
            cd
            screen -r gensyn
            ;;
            
        4)
            echo -e "${BLUE}删除Gensyn节点...${NC}"

            # 找到所有包含“gensyn”的屏幕会话
            SESSION_IDS=$(screen -ls | grep "gensyn" | awk '{print $1}' | cut -d '.' -f 1)
    
            # 如果找到会话，删除它们
            if [ -n "$SESSION_IDS" ]; then
                echo -e "${BLUE}使用ID结束屏幕会话： $SESSION_IDS${NC}"
                for SESSION_ID in $SESSION_IDS; do
                    screen -S "$SESSION_ID" -X quit
                done
            else
                echo -e "${BLUE}没有找到Gensyn Noda的屏幕会话，继续删除${NC}"
            fi

            # 删除文件夹
            if [ -d "$HOME/rl-swarm" ]; then
                rm -rf $HOME/rl-swarm
                echo -e "${GREEN}Noda目录已删除${NC}"
            else
                echo -e "${RED}没有找到节点目录.${NC}"
            fi

            echo -e "${GREEN}重命名Gensyn!${NC}"

            # 输入输出
            echo -e "${PURPLE}-----------------------------------------------------------------------${NC}"
            echo -e "${GREEN}HMKK!${NC}"
            echo -e "${CYAN}QQ:178003849${NC}"
            sleep 1
            ;;

        *)
            echo -e "${RED}错误的选择。请输入1到4的号码！${NC}"
            ;;
    esac
