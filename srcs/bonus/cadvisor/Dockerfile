FROM alpine:3.16

# Installer les dépendances nécessaires
RUN apk add --no-cache \
    curl

# Télécharger et installer cAdvisor
RUN curl -L -o /usr/local/bin/cadvisor "https://github.com/google/cadvisor/releases/download/v0.49.2/cadvisor-v0.49.2-linux-amd64" && \
    chmod +x /usr/local/bin/cadvisor

# Exposer le port utilisé par cAdvisor
EXPOSE 8080

# Lancer cAdvisor
CMD ["/usr/local/bin/cadvisor", "-logtostderr"]