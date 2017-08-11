export REPOSITORY ?= hub.docker.com
export DOCKER_REG_USERNAME ?=
export DOCKER_REG_PASSWORD ?=

DOCKER_COMPOSE ?= docker-compose

IMAGE_NAME ?= jenkinsfile-master

.PHONY: build push deploy down patch

build:
	cd image; docker build -t $(IMAGE_NAME) .

patch:
	cd image; docker build -t $(IMAGE_NAME) -f Dockerfile.patch  .

push: build
	IMAGE_NAME=$(IMAGE_NAME) ./docker-push.sh

down:
	$(DOCKER_COMPOSE) down

up:
	$(DOCKER_COMPOSE) up -d

local:
	$(DOCKER_COMPOSE) -f docker-compose.yml -f docker-compose.local.yml up -d
clean:
	# supply minus v flag to indicate to tear down named volumes.
	$(DOCKER_COMPOSE) down -v
