#! /bin/bash
#
# Data Backup script that creates a service to perform backups of /home directory 

echo "Hello! Welcome to the Back Up Tool Script!"
echo "We will check what user's folders are in /home and craete a service to perform backups. \n"

## Figure out who/what/when/where
ls -lh /home

MY_HOME= $HOME
echo "Is this your home? $MY_HOME \n"

echo "Enter home dir or dir you want backed up"
read -p "$HOME" MY_HOME

BACKUPDIR=/mnt/backups

echo "Where would you like the backups to be put? (Defaults to /mnt/backups) \n"
read -p "$BACKUPDIR" BACKUPDIR

BACKUPTIME=weekly
echo "How often you want backup? (daily, weekly, or monthly)"

read BACKUPTIME

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

sudo cp AABackup.service /etc/systemd/system/

touch AABackup.timer

echo "[Unit]" >> AABackup.timer
echo "Description=Back Up Tool Timer Service" >> AABackup.timer
echo "[Timer]" >> AABackup.timer
echo "OnCalendar=$BACKUPTIME " >> AABackup.timer
echo "Persistent=True" >> AABackup.timer
echo "[Install]" >> AABackup.timer
echo "WantedBy=timers.target" >> AABackup.timer

sudo cp AABackup.timer /etc/systemd/system/

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