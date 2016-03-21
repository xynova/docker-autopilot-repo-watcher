#! /bin/bash

cat << EOF > /etc/systemd/system/docker-tcp.socket
[Unit]
Description=Docker Socket for the API

[Socket]
ListenStream=2375
Service=docker.service
BindIPv6Only=both

[Install]
WantedBy=sockets.target
EOF

systemctl stop docker && systemctl enable docker-tcp.socket && systemctl start docker
