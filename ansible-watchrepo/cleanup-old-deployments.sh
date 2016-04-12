#! /bin/bash

scriptdir=$(cd "$(dirname $0)"; pwd)

# Expects -e NEW_VERSION=?
ansible-playbook \
	-e GITREPOS_DIR=$GITREPOS_DIR \
	-e DOCKER_HOST=$DOCKER_HOST \
	$@ \
	${scriptdir}/cleanup-old-deployments.yml
