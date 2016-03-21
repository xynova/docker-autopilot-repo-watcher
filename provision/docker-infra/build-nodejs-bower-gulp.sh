#! /bin/bash

cat << EOF | docker build -t nodejs-bower-gulp:latest -t nodejs-bower-gulp:local -
FROM node
RUN npm install -g bower gulp 
WORKDIR /data 
CMD ["bash"]' 
EOF
