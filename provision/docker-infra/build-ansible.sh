#! /bin/bash

DOCKER_BIN=$(which docker)
LIBDEV_BIN=$(ldconfig -p | grep 'libdevmapper.so.1.02' | awk '{print $4}')
LIBDEV_BIN_NAME=$(echo $LIBDEV_BIN | sed 's#.*/##')
TEMP_DIR=tmp-ansible-build
DOCKER_GID=$(id docker -g) 

mkdir -p $TEMP_DIR
cp $DOCKER_BIN $TEMP_DIR
cp $LIBDEV_BIN $TEMP_DIR

cat << EOF > $TEMP_DIR/Dockerfile && docker build -t node.local/ansible:latest $TEMP_DIR
FROM docker.io/library/debian:latest

COPY docker $DOCKER_BIN
COPY $LIBDEV_BIN_NAME /usr/lib/$LIBDEV_BIN_NAME

RUN apt-get update \
	&&  apt-get install -y python-pip python-dev git sudo vim

RUN pip install PyYAML jinja2 paramiko httplib2

RUN git clone -b stable-2.0.0.1 https://github.com/ansible/ansible.git --recursive \
	&& cd ansible \
	&& make install

RUN mkdir /etc/ansible \
	&& cp /ansible/examples/hosts /etc/ansible/hosts.bak \
	&& echo "[local]\\nlocalhost\\n" > /etc/ansible/hosts \
	&& echo "[defaults]\\nremote_tmp=/tmp/.ansible/tmp\\n"

RUN groupadd -g $DOCKER_GID docker \
	&& useradd --create-home ansible \
	&& usermod -aG ansible,docker ansible \
	&& echo "%ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ansible
WORKDIR /home/ansible
EOF


# Cleanup
rm -Rf $TEMP_DIR


