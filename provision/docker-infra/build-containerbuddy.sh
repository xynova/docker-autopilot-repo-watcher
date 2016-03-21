#! /bin/bash

cat << EOF | docker build -t containerbuddy:latest -t containerbuddy:local -
FROM debian:latest

RUN apt-get update && apt-get -y install curl
RUN cd /tmp && /usr/bin/curl -L https://github.com/joyent/containerbuddy/releases/download/1.1.0/containerbuddy-1.1.0.tar.gz \ 
	| /bin/tar -xvz \
	&& /bin/mv containerbuddy /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/containerbuddy","--config"]
CMD ["file:///etc/containerbuddy/config.json"]
EOF
