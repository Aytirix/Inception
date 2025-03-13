FROM alpine:3.16

# Installer nginx et openssl
RUN apk update && apk add --no-cache nginx openssl

# Copier le fichier de configuration principal dans /etc/nginx/
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copier tout les .conf dans /etc/nginx/conf.d/ sauf le fichier default.conf
COPY conf/*.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/nginx.conf

# Générer la clé privée (server.key), le CSR et le certificat auto-signé
RUN mkdir -p /etc/nginx/ssl
RUN openssl genpkey -algorithm RSA -out /etc/nginx/ssl/server.key && \
    openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=FR/ST=Paris/L=Paris/O=MonEntreprise/OU=IT/CN=thmouty.42.fr" && \
    openssl x509 -req -days 365 -in /etc/nginx/ssl/server.csr -signkey /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt


EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
