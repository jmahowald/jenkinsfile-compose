#!/bin/sh

# H/T: https://raw.githubusercontent.com/SvenDowideit/docs-automation/master/jenkins/setup-docker-and-start-jenkins.sh

# this makes it so that jenkins user can interact with the hosts docker

set -e

JUSER="jenkins"
JENKINS_HOME="${JENKINS_HOME:-/var/jenkins_home}"

DOCKER_GID=$(ls -aln /var/run/docker.sock  | awk '{print $4}')

# TODO: can we also download the static docker client binary for the
#       docker server version?

if ! getent group $DOCKER_GID; then
	echo creating docker group $DOCKER_GID
	addgroup --gid $DOCKER_GID docker
fi

if ! getent group $GID; then
	echo creating $JUSER group $GID
	addgroup --gid $GID $JUSER
fi

if ! getent passwd $JUSER; then
	echo useradd -N --gid $GID -u $UID $JUSER
	useradd -N --gid $GID -u $UID $JUSER
fi

DOCKER_GROUP=$(ls -al /var/run/docker.sock  | awk '{print $4}')
if ! id -nG "$JUSER" | grep -qw "$DOCKER_GROUP"; then
	adduser $JUSER $DOCKER_GROUP
fi



if [ -d "$JOB_BASE_CONFIG_DIR" ]; then
	echo Found some base jobs in $JENKINS_JOBS_DIR copying over job definitions
	cp -rf $JOB_BASE_CONFIG_DIR/* $JENKINS_HOME/jobs/
fi


chown -R $JUSER:$JUSER $JENKINS_HOME

exec su $JUSER -c "/bin/tini -s -- /usr/local/bin/jenkins.sh"
