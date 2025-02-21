FROM alpine:3.16


# Installer MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils

# Créer le répertoire pour les bases de données
RUN mkdir -p /var/lib/mysql

# Ouverture du port 3306
EXPOSE 3306

# Copier le fichier de configuration principal dans /etc/mysql/
COPY conf/my.cnf /etc/my.cnf

# Copier le script de démarrage dans le répertoire /tmp
COPY tools/start.sh /tmp/start.sh