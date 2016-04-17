#! /bin/bash
set -e

cat << EOF | docker build -t node.local/confd:latest -
FROM docker.io/library/debian:latest

RUN apt-get update && apt-get -y install curl
RUN cd /tmp && curl -L https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 > confd \
	&& chmod +x confd \
	&& /bin/mv confd /usr/local/bin/

RUN useradd --uid 5000 --create-home confd \
	&& usermod -aG confd confd

USER confd
WORKDIR /home/confd

ENTRYPOINT ["/usr/local/bin/confd", "-backend", "etcd" ]
EOF
