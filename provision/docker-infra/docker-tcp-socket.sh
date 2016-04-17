#! /bin/bash
set -e

cat << EOF > /etc/systemd/system/docker-tcp.socket
[Unit]
Description=Docker Socket for the API
Before=docker.service

[Socket]
ListenStream=2375
Service=docker.service
BindIPv6Only=both

[Install]
WantedBy=sockets.target
EOF


systemctl stop docker.service 
systemctl enable docker-tcp.socket && systemctl start docker-tcp.socket 
systemctl enable docker.service && systemctl start docker.service
