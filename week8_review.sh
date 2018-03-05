#! /bin/bash
#
# Data Backup script that creates a service to perform backups of /home directory 

echo "Hello! Welcome to the Back Up Tool Script!"
echo "We will check what user's folders are in /home and craete a service to perform backups."

touch AABackup.service

echo "[Unit]" >> AABackup.service
echo "Description=Back Up Tool Service" >> AABackup.service
echo "[Unit]" >> AABackup.service
echo "Description=Backup" >> AABackup.service
echo "Wants=" >> AABackup.service

cp AABackup.service /etc/systemd/system/

echo "And run it!"
systemctl start AABackup.service

echo "Now we can check it's status"
systemctl status AABackup.service

echo "And check all current jobs"
systemctl list-jobs
