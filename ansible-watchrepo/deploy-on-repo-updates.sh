#! /bin/bash
scriptdir=$(cd "$(dirname $0)"; pwd)

ansible-playbook \
	-e GITREPOS_DIR=$GITREPOS_DIR \
	-e DOCKERDATA_DIR=$DOCKERDATA_DIR \
	-e GIT_WATCHED_REPO_URL="$GIT_WATCHED_REPO_URL" \
	-e GIT_WATCHED_REPO_BRANCH="${GIT_WATCHED_REPO_BRANCH:=master}" \
	-e HOST_IP=$HOST_IP \
	-e DOCKER_HOST=$DOCKER_HOST \
	-e SLACK_TOKEN=$SLACK_TOKEN \
	-e SLACK_CHANNEL=$SLACK_CHANNEL \
	$@ \
	${scriptdir}/deploy-on-repo-updates.yml
