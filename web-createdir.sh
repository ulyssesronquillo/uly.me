#!/bin/bash

createdir () {

  if [ $# -eq 0 ]
  then
    echo "Format: web-createdir.sh domain.tld"
  else
    cd /var/www/
    echo "Create directory for: " $1
    sudo mkdir /var/www/$1
    sudo mkdir /var/www/$1/html
    sudo mkdir /var/www/$1/log
    sudo mkdir /var/www/$1/backup
    sudo chown -R ubuntu:www-data /var/www/$1
    sudo chmod -R 755 $1
    echo "Done!"
  fi

}

createdir

