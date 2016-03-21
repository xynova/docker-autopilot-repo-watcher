#! /bin/bash
scriptdir=$(cd "$(dirname $0)"; pwd)

ansible-playbook \
	-e DOCKERDATA_DIR=$DOCKERDATA_DIR \
	-e HOST_IP=$HOST_IP \
	-e DOCKER_HOST=$DOCKER_HOST \
	$@ \
	${scriptdir}/resync-gateway.yml
