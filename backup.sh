#!/bin/bash
cd /root/database
TIMESTAMP=$(date +%Y-%m-%d)
S3FILE1="s3://uly.me/sqlbackup/backup-ulyme-$TIMESTAMP.sql"
S3FILE2="s3://uly.me/sqlbackup/backup-ulyssesonline-$TIMESTAMP.sql"
/usr/bin/mysqldump ulyme > ulyme.sql
/usr/bin/mysqldump ulyssesonline > ulyssesonline.sql
/usr/bin/aws s3 cp ulyme.sql $S3FILE1
/usr/bin/aws s3 cp ulyssesonline.sql $S3FILE2
sleep 3s
rm *.sql
