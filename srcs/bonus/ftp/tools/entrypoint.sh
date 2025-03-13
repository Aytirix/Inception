#!/bin/sh

# Vérifier si le dossier /var/www/html existe
if [ -d "/var/www/html" ]; then
	addgroup -S wp-data
	adduser -S www-data -G wp-data
	adduser $FTP_USER wp-data
    chown -R www-data:wp-data /var/www/html
    chmod -R 775 /var/www/html

    echo "Dossier /var/www/html existant et permissions appliquées."
fi

exec vsftpd /etc/vsftpd.conf
