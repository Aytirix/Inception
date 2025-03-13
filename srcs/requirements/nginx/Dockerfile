FROM alpine:3.16

# Installer nginx et openssl
RUN apk update && apk add --no-cache nginx openssl

# Copier le fichier de configuration principal dans /etc/nginx/
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Copier tout les .conf dans /etc/nginx/conf.d/ sauf le fichier default.conf
COPY conf/*.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/nginx.conf

# Copier les certificats SSL dans un dossier, par exemple /etc/nginx/ssl
COPY tools/ssl /etc/nginx/ssl

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
