port ouvert : netstat -tuln
executer une commander dans un container : docker exec -it {container_name} {command}
connecter mysql : mysql -h {container_ip_or_hostname} -u {username} -p
clear docker du pc : docker system prune -a