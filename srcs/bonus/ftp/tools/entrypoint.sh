#!/bin/sh

# Vérifier si le dossier existe
if [ -d "/var/www/html" ]; then
    # Trouver les fichiers appartenant à root et les donner à l'utilisateur FTP
    find /var/www/html -user root -exec chown ${FTP_USER}:${FTP_USER} {} \;
fi

# Démarrer vsftpd
exec vsftpd /etc/vsftpd.conf