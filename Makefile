DOCKER_COMPOSE_FILE=srcs/docker-compose.yml
DOCKER_COMPOSE=docker-compose

.PHONY: up down build rebuild logs

up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --rmi all
	docker volume prune -f

stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start

re: down build up

logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f