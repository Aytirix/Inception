#!/bin/sh

until mysqladmin ping -h mariadb -u ${WP_DB_ADMIN_USER} -p${WP_DB_ADMIN_PASSWORD} --silent; do
    sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Création du fichier wp-config.php..."
    wp config create --dbname="${WP_DB_NAME}" --dbuser="${WP_DB_ADMIN_USER}" --dbpass="${WP_DB_ADMIN_PASSWORD}" --dbhost="mariadb" --path=/var/www/html --allow-root
fi

if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installation de WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="Mon Site" \
        --admin_user="${WP_DB_ADMIN_USER}" \
        --admin_password="${WP_DB_ADMIN_PASSWORD}" \
        --admin_email="${WP_DB_ADMIN_EMAIL}" \
        --path=/var/www/html \
        --allow-root
fi

php-fpm81 --nodaemonize