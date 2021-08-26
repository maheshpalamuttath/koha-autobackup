#!/bin/bash
mysqldump -ukoha_library -ppassword koha_library | gzip > /home/username/gdrive/koha_library-$(date +%d-%m-%Y-%H.%M).sql.gz
rclone sync /home/username/gdrive/koha_library-$(date +%d-%m-%Y-%H.%M).sql.gz Gdrive:KOHA-DBBACKUPS
find /home/username/gdrive/* -mtime +3 -exec rm {} \;
