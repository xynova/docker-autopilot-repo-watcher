#! /bin/bash
set -e

cat << EOF | docker build -t node.local/containerbuddy:latest -
FROM docker.io/library/debian:latest

RUN apt-get update && apt-get -y install curl
RUN cd /tmp && /usr/bin/curl -L https://github.com/joyent/containerbuddy/releases/download/1.1.0/containerbuddy-1.1.0.tar.gz \ 
	| /bin/tar -xvz \
	&& /bin/mv containerbuddy /usr/local/bin/

RUN useradd --uid 10010 --create-home buddy \
	&& usermod -aG buddy buddy

USER buddy
WORKDIR /home/buddy

ENTRYPOINT ["/usr/local/bin/containerbuddy","--config"]
CMD ["file:///etc/containerbuddy/config.json"]
EOF
