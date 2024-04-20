#!/bin/bash

# 定义要监控的容器名称列表
containers=(titan1 titan2 titan3 titan4 titan5)

# 检查并启动容器
start_containers() {
    for container in "${containers[@]}"
    do
        if ! docker ps --format '{{.Names}}' | grep -q "$container"; then
            echo "Starting container: $container"
            docker start "$container"
        fi
    done
}

# 停止容器
stop_containers() {
    for container in "${containers[@]}"
    do
        echo "Stopping container: $container"
        docker stop -t 2 "$container"
    done
}

# 监控容器状态并重启
monitor_containers() {
    while true
    do
        for container in "${containers[@]}"
        do
            if ! docker ps --format '{{.Names}}' | grep -q "$container"; then
                echo "Container $container is not running, restarting..."
                docker start "$container"
            fi
        done
        sleep 5
    done
}

# 根据传入的参数执行相应操作
case "$1" in
    start)
        start_containers
        ;;
    stop)
        stop_containers
        ;;
    monitor)
        monitor_containers
        ;;
    *)
        echo "Usage: $0 {start|stop|monitor}"
        exit 1
        ;;
esac
