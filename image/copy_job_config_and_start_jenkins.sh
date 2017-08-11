#/bin/bash
# This script is just so we can copy jenkins job configs over
# and bake it in with the project, while still allowing all of the 
# jenkins run time data to be in a separate volume



sh -c "mkdir -p $JENKINS_JOBS_DIR; cp -rf $JOB_BASE_CONFIG_DIR/* $JENKINS_JOBS_DIR/;
/usr/local/bin/jenkins.sh $@"
