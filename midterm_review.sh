#! /bin/bash
#
# Data Backup script that creates a service to perform backups of /home directory 
# In order to undo this script, please run the following commands:
# sudo systemctl stop AABackup.service
# sudo systemctl stop AABackup.timer
# sudo systemctl disable AABackup.service
# sudo systemctl disable AABackup.service
# sudo rm /etc/systemd/system/AABackup.*

echo -e "Hello! Welcome to the Back Up Service Tool!"
echo -e "We will check what user's folders are in /home and craete a service to perform backups. \n"

## Figure out who/what/when/where
ls -lh /home

MY_HOME= $HOME
echo -e "Is this your home? $MY_HOME \n"

### Prompt for the source Dir
echo "Enter home dir or dir you want backed up"
read -e -p "Home: " -i "$HOME" MY_HOME

BACKUPDIR=/mnt/backups

### Prompt for the Backup destination Dir
echo -e "\nWhere would you like the backups to be put? (Defaults to /mnt/backups)"
read -e -p "Backup Dir: " -i "$BACKUPDIR" BACKUPDIR

### Prompt for the backup interval
BACKUPTIME=weekly
echo -e "\nHow often you want backup? (daily, weekly, or monthly)"
read -e -p "Interval: " -i "$BACKUPTIME" BACKUPTIME

### Create Service
touch AABackup.service

echo "[Unit]" >> AABackup.service
echo "Description=Back Up Tool Service" >> AABackup.service
echo "Requires=" >> AABackup.service
echo "[Service]" >> AABackup.service
echo "Type=simple" >> AABackup.service
echo "ExecStart=/usr/bin/rsync -avzr $MY_HOME $BACKUPDIR" >> AABackup.service
echo "[Install]" >> AABackup.service
echo "WantedBy=multi-user.target" >> AABackup.service

### Create the Service Timer
touch AABackup.timer

echo "[Unit]" >> AABackup.timer
echo "Description=Back Up Tool Timer Service" >> AABackup.timer
echo "[Timer]" >> AABackup.timer
echo "OnCalendar=$BACKUPTIME " >> AABackup.timer
echo "Persistent=True" >> AABackup.timer
echo "[Install]" >> AABackup.timer
echo "WantedBy=timers.target" >> AABackup.timer

### Copy the files to the systemd folder
sudo cp AABackup.service /etc/systemd/system/
sudo cp AABackup.timer /etc/systemd/system/

### Start the service
echo "And run it!"
sudo systemctl start AABackup.service
sudo systemctl start AABackup.timer
sudo systemctl enable AABackup.timer

echo "Now we can check it's status"
sudo systemctl status AABackup.service

echo "And check all current jobs"
sudo systemctl list-jobs

# Cleanup

rm AABackup.*
