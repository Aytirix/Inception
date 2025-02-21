FROM alpine:3.16

# Installer nginx et openssl
RUN apk update && apk add --no-cache nginx openssl

# Copier le fichier de configuration principal dans /etc/nginx/
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copier la configuration du serveur dans le répertoire dédié
COPY conf/default.conf /etc/nginx/conf.d/default.conf

# Copier les certificats SSL dans un dossier, par exemple /etc/nginx/ssl
COPY tools/ssl /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
