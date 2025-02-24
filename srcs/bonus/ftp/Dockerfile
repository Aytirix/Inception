# Choisir une image de base légère
FROM alpine:3.16

# Mettre à jour et installer vsftpd

RUN apk update && apk add vsftpd openssl

# /var/run/vsftpd/empty
RUN mkdir -p /var/run/vsftpd/empty && \
    chown root:root /var/run/vsftpd/empty && \
    chmod 755 /var/run/vsftpd/empty

# Créer un répertoire pour stocker les certificats
RUN mkdir -p /etc/ssl/certs /etc/ssl/private
RUN chmod 700 /etc/ssl/private

# Générer un certificat SSL et une clé privée
RUN openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/vsftpd.key -out /etc/ssl/certs/vsftpd.pem -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

# log de vsftpd
RUN touch /var/log/vsftpd.log
RUN chmod 777 /var/log/vsftpd.log
RUN chown root:root /var/log/vsftpd.log

# Créer un script d'initialisation pour créer l'utilisateur FTP
COPY tools/start.sh /start.sh
RUN chmod +x /start.sh

# Configurer vsftpd
COPY conf/vsftpd.conf /etc/vsftpd.conf

# Exposer le port FTP (21)
EXPOSE 21

# Démarrer vsftpd
CMD ["/bin/sh", "-c", "/start.sh && vsftpd /etc/vsftpd.conf"]