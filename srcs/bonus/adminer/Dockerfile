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
	mariadb-client \
	openssh-client \
    && rm -rf /var/cache/apk/*

# Création du lien symbolique pour PHP
RUN ln -s /usr/bin/php81 /usr/bin/php

# créer dossier wordpress
RUN mkdir -p /var/www/html/adminer

# Téléchargement et installation de WordPress
WORKDIR /var/www/html/adminer

# Création de l'utilisateur www-data
RUN adduser -S www-data -G www-data

RUN mkdir -p /var/www/html/adminer && \
	wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php && \
	chown -R www-data:www-data /var/www/html/adminer

# Copie du fichier de configuration PHP-FPM
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Exposition du port pour PHP-FPM
EXPOSE 9000

# lance PHP-FPM
CMD ["php-fpm81", "--nodaemonize"]