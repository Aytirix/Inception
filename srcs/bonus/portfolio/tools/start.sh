#!/bin/sh

until mysqladmin ping -h mariadb -u ${WP_DB_USER} -p${WP_DB_PASSWORD} --silent; do
    sleep 2
done

if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Création du fichier wp-config.php..."
    wp config create --dbname="${WP_DB_NAME}" \
	--dbuser="${WP_DB_USER}" \
	--dbpass="${WP_DB_PASSWORD}" \
	--dbhost="mariadb" \
	--dbprefix="${WP_TABLE_PREFIX}" \
	--path=/var/www/html/wordpress \
	--allow-root
fi

if ! wp core is-installed --path=/var/www/html/wordpress --allow-root; then
    echo "Installation de WordPress..."
    wp core install \
        --url="thmouty.42.fr" \
        --title="Mon Site" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www/html/wordpress \
        --allow-root

	wp user create "${WP_EDITOR_USER}" "${WP_EDITOR_EMAIL}" \
		--role=editor \
		--user_pass="${WP_EDITOR_PASSWORD}" \
		--path=/var/www/html/wordpress
fi

# Si le dossier /var/www/html/portfolio n'existe pas, on le crée
if [ ! -d /var/www/html/portfolio ]; then
	eval $(ssh-agent -s)
	ssh-add /root/.ssh/ssh_portfolio.priv
	rm -rf /var/www/html/portfolio
	git clone git@github.com:Aytirix/portfolio.git /var/www/html/portfolio
fi

# Téléchargement et installation d'Adminer
if [ ! -f /var/www/html/adminer/index.php ]; then
	mkdir -p /var/www/html/adminer && \
	wget "https://www.adminer.org/latest.php" -O /var/www/html/adminer/index.php && \
	chown -R www-data:www-data /var/www/html/adminer
fi

php-fpm81 --nodaemonize