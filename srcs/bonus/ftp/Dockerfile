# Utilisation d'une image légère
FROM alpine:3.16

# Mise à jour et installation de vsftpd et OpenSSL
RUN apk update && apk add vsftpd openssl

ARG FTP_USER
ARG FTP_PASSWORD

# Création du log de vsftpd
RUN touch /var/log/vsftpd.log && chmod 640 /var/log/vsftpd.log && chown root:root /var/log/vsftpd.log

# Création de l'utilisateur FTP avec un répertoire dédié

RUN echo "${FTP_USER}:${FTP_PASSWORD}"

# Créer un utilisateur et un répertoire pour le serveur FTP
RUN adduser -D -s /bin/sh "${FTP_USER}" && \
	mkdir -p /home/${FTP_USER}/ftp && \
	echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd && \
	chown ${FTP_USER}:${FTP_USER} /home/${FTP_USER}/ftp && \
	chmod 550 /home/${FTP_USER} && \
	chmod 750 /home/${FTP_USER}/ftp
	
# Copie du fichier de configuration de vsftpd
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Exposition des ports FTP et passifs
EXPOSE 21
EXPOSE 21000

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Lancer le script d'entrée
ENTRYPOINT ["/entrypoint.sh"]
