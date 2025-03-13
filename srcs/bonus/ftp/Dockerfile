# Utilisation d'une image légère
FROM alpine:3.16

# Mise à jour et installation de vsftpd et OpenSSL
RUN apk update && apk add vsftpd openssl

ARG FTP_USER
ARG FTP_PASSWORD

# Création du log de vsftpd
RUN touch /var/log/vsftpd.log && chmod 640 /var/log/vsftpd.log && chown root:root /var/log/vsftpd.log

# Créer un utilisateur et un répertoire pour le serveur FTP
RUN adduser -D -s /bin/sh "${FTP_USER}" && \
	echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd

COPY conf/vsftpd.conf /etc/vsftpd.conf

# Exposition des ports FTP et passifs
EXPOSE 21
EXPOSE 21000

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Lancer le script d'entrée
ENTRYPOINT ["/entrypoint.sh"]
