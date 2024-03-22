#!/bin/bash

id="$1"
echo $id

apt update

sudo apt-get install ca-certificates curl gnupg lsb-release

# 添加 Docker 官方 GPG 密钥
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# 设置 Docker 仓库
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 授权 Docker 文件
sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

# 安装 Docker 最新版本
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# 拉取Docker镜像
docker pull nezha123/titan-edge:1.1

# 创建5个容器
for i in {1..5}
do
    # 为每个容器创建一个存储卷
    storage="titan_storage_$i"
    mkdir -p "$storage"

    # 运行容器，并设置重启策略为always
    container_id=$(docker run -d --restart always -v "$PWD/$storage:/root/.titanedge/storage" --name "titan$i" nezha123/titan-edge:1.1)

    echo "Container titan$i started with ID $container_id"

    sleep 30
    
    # 进入容器并执行绑定和其他命令
    docker exec -it $container_id bash -c "\
        titan-edge bind --hash=$id https://api-test1.container1.titannet.io/api/v2/device/binding"
done


echo "==============================所有容器均已设置并启动===================================."

