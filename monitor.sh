#!/bin/bash

# 容器名称数组
containers=("titan1" "titan2" "titan3" "titan4" "titan5")

# 循环检查每个容器的状态
for container in "${containers[@]}"
do
    # 获取容器状态
    status=$(docker inspect --format='{{.State.Running}}' "$container" 2>/dev/null)

    # 如果容器没有运行
    if [ "$status" != "true" ]; then
        echo "容器 $container 没有运行,尝试重启..."
        
        # 尝试重启容器
        docker start "$container" >/dev/null 2>&1
        
        # 如果重启失败,则重新运行容器
        if [ $? -ne 0 ]; then
            echo "重启容器 $container 失败,尝试重新运行..."
            docker run -d --name="$container" "$container"
        fi
    fi
done
