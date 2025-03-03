# Utilisation de l'avant-dernière version stable d'Alpine
FROM alpine:3.16

# Variables d'environnement pour WordPress

# Installation des paquets nécessaires
RUN apk update && apk add --no-cache \
    php81 \
    php81-fpm \
    php81-mysqli \
    php81-json \
    php81-opcache \
    php81-curl \
    php81-gd \
    php81-mbstring \
    php81-xml \
    php81-zip \
    php81-session \
    php81-tokenizer \
	php81-phar \
    wget \
    tar \
    bash \
    curl \
	busybox-extras \
	git \
	openssh-client \
    && rm -rf /var/cache/apk/*

# Création du lien symbolique pour PHP
RUN ln -s /usr/bin/php81 /usr/bin/php

RUN mkdir -p /var/www/html

# Téléchargement et installation de portfolio
WORKDIR /var/www/html

# Création de l'utilisateur www-data
RUN adduser -S www-data -G www-data

# Création du dossier SSH et copie de la clé
RUN mkdir -p /root/.ssh && \
	chmod 700 /root/.ssh
COPY conf/ssh_portfolio.priv /root/.ssh/ssh_portfolio.priv
RUN chmod 600 /root/.ssh/ssh_portfolio.priv && \
	ssh-keyscan -H github.com >> /root/.ssh/known_hosts

# Ajout de la clé privée au ssh-agent pour l'authentificatione
RUN eval $(ssh-agent -s) && ssh-add /root/.ssh/ssh_portfolio.priv

# Copie du fichier de configuration PHP-FPM
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Copie du script de démarrage
COPY tools/start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh

# Exposition du port pour PHP-FPM
EXPOSE 9001

# executer le script de démarrage
ENTRYPOINT ["/tmp/start.sh"]