#! /bin/bash


DOCKER_GID=$(id docker -g) && cat << EOF | docker build -t ansible:latest -t ansible:local -
FROM ubuntu:15.04
MAINTAINER Hector Maldonado (xynova)

RUN apt-get -y update && apt-get install -y software-properties-common \
	&& add-apt-repository ppa:ansible/ansible && add-apt-repository ppa:git-core/ppa \
	&& apt-get -y update && apt-get install -y sqlite3 sqlite3-doc python-setuptools vim sudo git-core ansible
RUN groupadd -g $DOCKER_GID docker && useradd --create-home ansible && usermod -aG ansible,sudo --gid $DOCKER_GID ansible \
	&& echo "%ansible ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN mv /etc/ansible/hosts /etc/ansible/hosts.bak && echo "[local]\\nlocalhost\\n" > /etc/ansible/hosts

USER ansible
WORKDIR /home/ansible
EOF
