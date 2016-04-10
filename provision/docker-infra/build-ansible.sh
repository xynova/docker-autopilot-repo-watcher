#! /bin/bash


DOCKER_GID=$(id docker -g) && cat << EOF | docker build -t node.local/ansible:latest -
FROM docker.io/library/debian:latest
MAINTAINER Hector Maldonado (xynova)

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
