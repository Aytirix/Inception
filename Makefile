# Variables
DOCKER_COMPOSE_FILE=srcs/docker-compose.yml
DOCKER_COMPOSE=docker-compose

# Targets
.PHONY: up down build rebuild logs

up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --rmi all
	docker volume prune -f

build:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start

re: down build up

logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f