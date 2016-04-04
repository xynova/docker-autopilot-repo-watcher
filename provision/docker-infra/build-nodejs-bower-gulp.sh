#! /bin/bash

cat << EOF | docker build -t nodejs-bower-gulp:latest -t nodejs-bower-gulp:local -
FROM node
RUN npm install -g bower gulp 

RUN useradd --create-home node \
	&& usermod -aG node node 

USER node
WORKDIR /home/node

CMD ["bash"] 
EOF
