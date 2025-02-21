FROM alpine:3.16

# Installer MariaDB
RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client mariadb-server-utils

# Configurer MariaDB
RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Exposer le port
EXPOSE 3306

# Copier les fichiers de configuration et le script de démarrage
COPY conf/my.cnf /etc/mysql/mariadb.conf.d/
COPY tools/start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh

# Exécuter le script de démarrage
ENTRYPOINT ["/tmp/start.sh"]