#!/bin/sh

# Vérifier si les variables d'environnement sont définies
if [ -z "${FTP_USER}" ] || [ -z "${FTP_PASSWORD}" ]; then
    echo "Erreur : Les variables d'environnement FTP_USER st FTP_PASSWORD doivent être définies."
    exit 1
fi

# # Créer l'utilisateur FTP
if ! id -u "${FTP_USER}" > /dev/null 2>&1; then
	adduser -D "${FTP_USER}" && echo "${FTP_USER}:${FTP_PASSWORD}" | chpasswd
fi