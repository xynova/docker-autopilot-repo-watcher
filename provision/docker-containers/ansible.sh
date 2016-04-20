#! /bin/bash
set -e

WORK_DIR=$(git rev-parse --show-toplevel)
HOST_IP=$(ip addr | grep 'state UP' -A2 | grep -P [^\\w]+eth0 | tail -1 | awk '{print $2}' | cut -f1  -d'/')
SLACK_TOKEN=
SLACK_CHANNEL=
GIT_WATCHED_REPO_URL=https://github.com/xynova/stub-ng-site.git
GIT_WATCHED_REPO_BRANCH=master
DEPLOYMENT_GROUP=master-branch

ANSIBLE_VOL=$WORK_DIR/ansible-watchrepo
CONFIG_VOL=$WORK_DIR/dockerdata
REPO_VOL=$WORK_DIR/gitrepos/${GIT_WATCHED_REPO_BRANCH}
 
docker run -it --rm \
	`#-v $(which docker):/usr/bin/docker:ro` \
	`#-v $(ldconfig -p | grep 'libdevmapper.so.1.02' | awk '{print $4}'):/usr/lib/libdevmapper.so.1.02:ro` \
	`# --security-opt label:disable `\
	-v $REPO_VOL:$REPO_VOL \
	-v $CONFIG_VOL:$CONFIG_VOL \
	-v $ANSIBLE_VOL:/home/ansible \
	-e DEPLOYMENT_GROUP=$DEPLOYMENT_GROUP \
	-e GITREPOS_DIR=$REPO_VOL \
	-e GIT_WATCHED_REPO_BRANCH=$GIT_WATCHED_REPO_BRANCH \
	-e DOCKERDATA_DIR=$CONFIG_VOL \
	-e HOST_IP=$HOST_IP \
	-e DOCKER_HOST="tcp://${HOST_IP}:2375" \
	-e SLACK_TOKEN=$SLACK_TOKEN \
	-e SLACK_CHANNEL=$SLACK_CHANNEL \
	-e GIT_WATCHED_REPO_URL=$GIT_WATCHED_REPO_URL \
	--name "ansible-watch-$DEPLOYMENT_GROUP" \
	node.local/ansible /bin/bash 

