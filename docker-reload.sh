echo '[Unit]
Description=Monitor and restart Titan containers
Requires=docker.service
After=docker.service

[Service]
Restart=always

ExecStart=/usr/bin/docker start -a titan1
ExecStop=/usr/bin/docker stop -t 2 titan1

ExecStart=/usr/bin/docker start -a titan2
ExecStop=/usr/bin/docker stop -t 2 titan2

ExecStart=/usr/bin/docker start -a titan3
ExecStop=/usr/bin/docker stop -t 2 titan3

ExecStart=/usr/bin/docker start -a titan4
ExecStop=/usr/bin/docker stop -t 2 titan4

ExecStart=/usr/bin/docker start -a titan5
ExecStop=/usr/bin/docker stop -t 2 titan5

[Install]
WantedBy=default.target' | sudo tee /etc/systemd/system/monitor-titan-containers.service


sudo systemctl daemon-reload
sudo systemctl enable monitor-titan-containers.service
sudo systemctl start monitor-titan-containers.service
