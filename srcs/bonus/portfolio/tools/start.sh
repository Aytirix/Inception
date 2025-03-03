#!/bin/sh

# Si le dossier /var/www/html/portfolio n'existe pas, on le crée
if [ ! -d /var/www/html ]; then
	eval $(ssh-agent -s)
	ssh-add /root/.ssh/ssh_portfolio.priv
	rm -rf /var/www/html
	git clone git@github.com:Aytirix/portfolio.git /var/www/html
	sudo chown -R www-data:www-data /var/www/html/
fi

php-fpm81 --nodaemonize