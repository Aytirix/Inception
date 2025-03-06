#!/bin/bash

# Configuration
debian_iso_url="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-12.9.0-amd64-netinst.iso"
debian_iso_path="$HOME/Downloads/debian-12.9.0-amd64-netinst.iso"
vm_disk_path="$HOME/sgoinfre/Inception/debian_vm.qcow2"
RAM=12
CORES=8
DISK_SIZE=20G

# Création du répertoire
mkdir -p "$HOME/sgoinfre/Inception"

# Vérification et téléchargement de l'ISO si nécessaire
if [ ! -f "$debian_iso_path" ]; then
	read -p "Voulez-vous télécharger l'ISO Debian maintenant ? (y/n) " download_choice
	if [[ "$download_choice" =~ ^[Yy]$ ]]; then
		echo "Téléchargement de l'ISO Debian... dans $debian_iso_path"
		wget -O "$debian_iso_path" "$debian_iso_url"
	else
		echo "Téléchargement annulé."
		exit 1
	fi
fi

# Création du disque virtuel
if [ ! -f "$vm_disk_path" ]; then
    echo "Création du disque virtuel... dans $vm_disk_path"
    qemu-img create -f qcow2 "$vm_disk_path" "$DISK_SIZE"

    echo "Démarrage de la VM pour l'installation..."
    qemu-system-x86_64 -m ${RAM}G -smp cores=${CORES},threads=2,sockets=1 -cpu host -enable-kvm \
        -net nic -net user -vga virtio -full-screen -daemonize \
        -hda "$vm_disk_path" \
        -cdrom "$debian_iso_path" \
        -boot d
    echo "VM lancée en arrière-plan pour l'installation."
else
	# Fonction pour lancer la VM après installation
	echo "Démarrage de la VM..."
	qemu-system-x86_64 -m ${RAM}G -smp cores=${CORES},threads=2,sockets=1 -cpu host -enable-kvm \
		-net nic -net user -vga virtio -full-screen -daemonize \
		-hda "$vm_disk_path"
	echo "VM en cours d'exécution."
fi
