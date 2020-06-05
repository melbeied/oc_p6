#!/usr/bin/env bash

set -e # Exit if any subcommand fails
set -x # Print commands for troubleshooting
apt-get update
apt upgrade -y
apt install curl wget unzip -y
# Install Gitlab
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
apt-get install gitlab-runner -y
# Install requirements for Symfony
apt install -y php php-bcmath php-cli php-curl php-zip php-sqlite3 php-mysql php-xml php-mbstring
#    wget https://getcomposer.org/composer.phar
#    mv composer.phar /usr/bin/composer
#    chmod +x /usr/bin/composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php --install-dir=/usr/local/bin --filename=composer