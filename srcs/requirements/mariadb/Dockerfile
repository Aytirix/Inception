FROM alpine:3.16

# Installer MariaDB
	RUN apk update && apk upgrade && apk add --no-cache mariadb mariadb-client mariadb-server-utils busybox-extras
# Configurer MariaDB
RUN mkdir -p /var/lib/mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Exposer le port
EXPOSE 3306

# Créer les fichers de logs
RUN mkdir -p /var/log/mysql && chown -R mysql:mysql /var/log/mysql
RUN touch /var/log/mysql/error.log && chown mysql:mysql /var/log/mysql/error.log
RUN touch /var/log/mysql/general.log && chown mysql:mysql /var/log/mysql/general.log

# Copier les fichiers de configuration et le script de démarrage
COPY conf/my.cnf /etc/my.cnf
COPY tools/start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh


# Exécuter le script de démarrage
ENTRYPOINT ["/tmp/start.sh"]