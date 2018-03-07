#! /bin/bash

sudo systemctl stop AABackup.service
sudo systemctl stop AABackup.timer
sudo systemctl disable AABackup.service
sudo systemctl disable AABackup.service
sudo rm /etc/systemd/system/AABackup.*
