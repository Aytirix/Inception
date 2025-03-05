DOCKER_COMPOSE_FILE=srcs/docker-compose.yml
DOCKER_COMPOSE=docker-compose

.PHONY: up down build rebuild logs

up:
	mkdir -p /home/theo/data
	mkdir -p /home/theo/data/html
	mkdir -p /home/theo/data/html/wordpress
	mkdir -p /home/theo/data/html/adminer
	mkdir -p /home/theo/data/mariadb
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans --rmi all
	docker volume prune -f
	sudo rm -rf /home/theo/data/*

stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start

re: down build up

logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f