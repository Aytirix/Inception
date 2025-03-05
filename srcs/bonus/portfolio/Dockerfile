FROM alpine:3.16

# Installation des paquets nécessaires
RUN apk update && apk add --no-cache \
    wget \
    tar \
    bash \
    curl \
    busybox-extras \
    unzip \
    && rm -rf /var/cache/apk/*

# Création du dossier portfolio
RUN mkdir -p /var/www/html/portfolio

# Création de l'utilisateur www-data
RUN adduser -S www-data -G www-data

# Copier le zip et extraire son contenu
WORKDIR /var/www/html/portfolio
COPY ./conf/portfolio.zip /tmp/portfolio.zip
RUN unzip /tmp/portfolio.zip -d /var/www/html/portfolio && \
    chown -R www-data:www-data /var/www/html/portfolio && \
    rm /tmp/portfolio.zip

# Exposer le port 9000
EXPOSE 9000

CMD ["httpd", "-f", "-p", "9000", "-h", "/var/www/html/portfolio"]