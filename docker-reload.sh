#!/bin/bash
echo '[Unit]
Description=Monitor and restart Titan containers
Requires=docker.service
After=docker.service

[Service]
Restart=always
ExecStart=/bin/bash -c '/usr/bin/docker start -a titan1 && /usr/bin/docker start -a titan2 && /usr/bin/docker start -a titan3 && /usr/bin/docker start -a titan4 && /usr/bin/docker start -a titan5'
ExecStop=/bin/bash -c '/usr/bin/docker stop -t 2 titan1 && /usr/bin/docker stop -t 2 titan2 && /usr/bin/docker stop -t 2 titan3 && /usr/bin/docker stop -t 2 titan4 && /usr/bin/docker stop -t 2 titan5'

[Install]
WantedBy=default.target' | sudo tee /etc/systemd/system/monitor-titan-containers.service


sudo systemctl daemon-reload
sudo systemctl enable monitor-titan-containers.service
sudo systemctl start monitor-titan-containers.service
