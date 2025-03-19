#!/bin/bash

# Configuration
debian_iso_path="$HOME/Downloads/debian-amd64-inception.iso"
vm_disk_path="$HOME/sgoinfre/Inception/debian_vm.qcow2"
RAM=12
CORES=8
DISK_SIZE=20G

# Création du répertoire
mkdir -p "$HOME/sgoinfre/Inception"

if [ ! -f "$vm_disk_path" ]; then
	if [ ! -f "$debian_iso_path" ]; then
		read -p "Voulez-vous télécharger l'ISO Debian maintenant ? (y/n) " download_choice
		if [[ "$download_choice" =~ ^[Yy]$ ]]; then
			LATEST_ISO_URL=$(wget -qO- "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS" | grep -oP 'debian-.*?-amd64-netinst\.iso' | head -1)

			# Vérification que l'URL a bien été trouvée
			if [ -z "$LATEST_ISO_URL" ]; then
				echo "Erreur : Impossible de récupérer l'URL de la dernière ISO Debian."
				exit 1
			fi

			echo "Téléchargement de l'ISO Debian version $LATEST_ISO_URL dans $debian_iso_path..."
			wget -O "$debian_iso_path" "https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$LATEST_ISO_URL"

			# Vérification que le fichier a bien été téléchargé
			if [ ! -f "$debian_iso_path" ] || [ ! -s "$debian_iso_path" ]; then
				echo "Erreur : Le téléchargement a échoué ou l'ISO est vide."
				rm -f "$debian_iso_path"
				exit 1
			fi
		else
			echo "Téléchargement annulé."
			exit 1
		fi
	fi

    echo "Création du disque virtuel... dans $vm_disk_path"
    qemu-img create -f qcow2 "$vm_disk_path" "$DISK_SIZE"

    echo "Démarrage de la VM pour l'installation..."
    qemu-system-x86_64 -m ${RAM}G -smp cores=${CORES},threads=2,sockets=1 -cpu host -enable-kvm \
        -net nic -net user -vga virtio \
        -hda "$vm_disk_path" \
        -cdrom "$debian_iso_path" \
        -boot d
    echo "VM lancée pour l'installation."
else
	echo "Démarrage de la VM..."
	qemu-system-x86_64 -m ${RAM}G -smp cores=${CORES},threads=2,sockets=1 -cpu host -enable-kvm \
		-net nic -net user -vga virtio -full-screen -daemonize \
		-hda "$vm_disk_path"
	echo "VM en cours d'exécution."
fi
