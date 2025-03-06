DOCKER_COMPOSE_FILE=srcs/docker-compose.yml
DOCKER_COMPOSE=docker-compose

.PHONY: up down build rebuild logs

up:
	sudo mkdir -p /home/thmouty/data
	sudo mkdir -p /home/thmouty/data/html
	sudo mkdir -p /home/thmouty/data/html/wordpress
	sudo mkdir -p /home/thmouty/data/html/adminer
	sudo mkdir -p /home/thmouty/data/html/portfolio
	sudo mkdir -p /home/thmouty/data/cadvisor
	sudo mkdir -p /home/thmouty/data/mariadb
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d --build

down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans --rmi all
	docker volume prune -f
	sudo rm -rf /home/thmouty/data/*

stop:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

start:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start

re: down build up

logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f