#!/bin/bash
sudo dnf update -y
sudo rpm -e --nodeps mariadb-libs-*
sudo amazon-linux-extras enable mariadb10.5 
sudo dnf clean metadata
sudo dnf install -y mariadb
sudo mysql -V
sudo dnf install -y telnet