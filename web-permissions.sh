#!/bin/bash

permissions () {
  sudo chown -R ubuntu:www-data /var/www
  find /var/www -type d -exec sudo chmod 775 {} \;
  find /var/www -type f -exec sudo chmod 664 {} \;
  sudo chmod +x /var/www/surfcali.com/html/generate.sh
  sudo chmod +x /var/www/surfcali.com/html/tides.sh
}

permissions

