#! /bin/bash

cat << EOF | docker build -t node.local/nodejs-bower-gulp:latest -
FROM docker.io/library/node
RUN npm install -g bower gulp 

RUN useradd --uid 10000 --create-home node \
	&& usermod -aG node node 

USER node
WORKDIR /home/node

CMD ["bash"] 
EOF
