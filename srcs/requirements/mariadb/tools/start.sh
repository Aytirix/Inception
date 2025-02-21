#!/bin/sh

# Vérifier si la base de données est déjà initialisée
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	mysqld_safe --skip-networking &

	until mysqladmin ping --silent; do
		sleep 2
	done

	# Créer la base et l'utilisateur si nécessaire
		mysql -u root <<-EOSQL
			ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
			CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
			CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
			GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
			FLUSH PRIVILEGES;
		EOSQL

	mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi


exec mysqld --user=mysql