#! /bin/bash

HOST_IP=$(ip addr | grep 'state UP' -A2 | grep eth0 | tail -1 | awk '{print $2}' | cut -f1  -d'/') \
&& docker run -d --restart unless-stopped --hostname ${HOSTNAME} \
	--name etcd -p 2379:2379 -p 2380 -e HOST_IP=${HOST_IP} \
	 quay.io/coreos/etcd \
	-advertise-client-urls http://${HOST_IP}:2379,http://127.0.0.1:2379 \
	-listen-client-urls http://0.0.0.0:2379 \
	-initial-advertise-peer-urls http://${HOST_IP}:2380 \
	-listen-peer-urls http://0.0.0.0:2380 \
	-initial-cluster-token etcd-cluster-1 \
	-name=${HOSTNAME} \
	-initial-cluster ${HOSTNAME}=http://${HOST_IP}:2380 \
	-initial-cluster-state new


