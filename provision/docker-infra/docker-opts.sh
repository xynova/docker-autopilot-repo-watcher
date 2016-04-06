#! /bin/bash

DIR=/etc/systemd/system/docker.service.d

mkdir -p $DIR && cat << EOF > "${DIR}/10-docker-opts.conf"
[Service]
Environment="DOCKER_OPTS=--log-driver=journald"
EOF

systemctl daemon-reload
systemctl restart docker
