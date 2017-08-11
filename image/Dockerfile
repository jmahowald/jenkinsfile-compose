FROM jenkins:2.32.2

VOLUME /var/jenkins_home

COPY plugins.txt .
RUN /usr/local/bin/plugins.sh plugins.txt

USER root

# H/T https://github.com/SvenDowideit/docs-automation/blob/master/jenkins/Dockerfile
RUN wget https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz && \
  tar -xvzf docker-latest.tgz && mv docker/docker /usr/bin/docker \
  && rm docker-latest.tgz

RUN apt-get update && apt-get install make -y

COPY setup-docker-and-start-jenkins.sh /
RUN chmod 755 /setup-docker-and-start-jenkins.sh  && chmod 755 /usr/bin/docker

ENTRYPOINT ["/setup-docker-and-start-jenkins.sh"]
