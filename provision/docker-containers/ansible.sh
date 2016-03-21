#! /bin/bash

WORK_DIR=$(git rev-parse --show-toplevel)
HOST_IP=$(ip addr | grep 'state UP' -A2 | grep -P [^\\w]+eth0 | tail -1 | awk '{print $2}' | cut -f1  -d'/')
SLACK_TOKEN=
SLACK_CHANNEL=
GIT_WATCHED_REPO_URL=https://github.com/xynova/stub-ng-site.git
 
docker run -it --rm \
	-v $(which docker):/usr/bin/docker:ro \
	-v $(ldconfig -p | grep 'libdevmapper.so.1.02' | awk '{print $4}'):/usr/lib/libdevmapper.so.1.02 \
	-v $WORK_DIR/gitrepos:$WORK_DIR/gitrepos -v $WORK_DIR/dockerdata:$WORK_DIR/dockerdata -v $WORK_DIR/ansible-watchrepo:/home/ansible \
	-e GITREPOS_DIR=$WORK_DIR/gitrepos -e DOCKERDATA_DIR=$WORK_DIR/dockerdata \
	-e HOST_IP=$HOST_IP \
	-e DOCKER_HOST="tcp://${HOST_IP}:2375" \
        -e SLACK_TOKEN=$SLACK_TOKEN \
        -e SLACK_CHANNEL=$SLACK_CHANNEL \
        -e GIT_WATCHED_REPO_URL=$GIT_WATCHED_REPO_URL \
	--name ansible-watchrepo \
	ansible bash 

