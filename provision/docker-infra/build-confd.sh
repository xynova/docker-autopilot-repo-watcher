#! /bin/bash

cat << EOF | docker build -t confd:latest -t confd:local -
FROM debian:latest

RUN apt-get update && apt-get -y install curl
RUN cd /tmp && curl -L https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 > confd \
	&& chmod +x confd \
	&& /bin/mv confd /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/confd", "-backend", "etcd" ]
EOF
