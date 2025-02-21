-- Création de la base de données
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

-- Création de l'utilisateur et attribution des privilèges
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

-- Appliquer les changements
FLUSH PRIVILEGES;
