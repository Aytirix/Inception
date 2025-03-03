#!/bin/sh

# Téléchargement de WordPress
wget https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz --strip-components=1 \
    && rm latest.tar.gz \
    && chown -R www-data:www-data /var/www/html

# Installation de WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
chmod +x wp-cli.phar && \
mv wp-cli.phar /usr/local/bin/wp

until mysqladmin ping -h mariadb -u ${WP_DB_USER} -p${WP_DB_PASSWORD} --silent; do
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Création du fichier wp-config.php..."
    wp config create --dbname="${WP_DB_NAME}" \
	--dbuser="${WP_DB_USER}" \
	--dbpass="${WP_DB_PASSWORD}" \
	--dbhost="mariadb" \
	--dbprefix="${WP_TABLE_PREFIX}" \
	--path=/var/www/html \
	--allow-root
fi

if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installation de WordPress..."
    wp core install \
        --url="thmouty.42.fr" \
        --title="Mon Site" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www/html \
        --allow-root

	wp user create "${WP_EDITOR_USER}" "${WP_EDITOR_EMAIL}" \
		--role=editor \
		--user_pass="${WP_EDITOR_PASSWORD}" \
		--path=/var/www/html \
fi

php-fpm81 --nodaemonize