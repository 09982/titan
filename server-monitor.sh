#!/bin/bash

PROC_NAME="titan-edge"
PROC_PATH="nohup ./titan_v0.1.14_linux_amd64/titan-edge daemon start --url https://test-locator.titannet.io:5000/rpc/v0  > edge.log 2>&1 &" # 启动titan-edge的脚本或命令路径

if ! pgrep -x "$PROC_NAME" >/dev/null; then
    echo "进程 $PROC_NAME 不存在,正在重启..."
    $PROC_PATH
fi

