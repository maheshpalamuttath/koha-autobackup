#!/bin/bash
 
# your backups will use this filename.
db_backup_name="koha_library-$(date +%d-%m-%Y-%H.%M).sql.gz"

## 1: Database connection info. You can get these details from your koha-conf.xml file.
db_name="koha_library"
db_username="koha_library"
db_password="koha123"
 
## 2: Path to your backup folder. Replace /home/username/ with path to your home directory.
backup_folder_path="/home/username/koha-backup"

## 3: Backup MYSQL/MariaDB database, gzip it and send to backup folder.
mysqldump --opt -u$db_username -p$db_password $db_name | gzip > $backup_folder_path/$db_backup_name

## 4: Sync to Google Drive using rclone
rclone sync /home/username/koha-backup/$db_backup_name Gdrive:KOHA-DBBACKUPS

## 5: Delete all but 5 recent Koha database back-ups (files having .sql.gz extension) in backup folder.
find $backup_folder_path -maxdepth 1 -name "*.sql.gz" -type f | xargs -x ls -t | awk 'NR>5' | xargs -L1 rm