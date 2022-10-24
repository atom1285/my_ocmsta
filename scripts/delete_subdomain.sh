#!/bin/sh

set -e

USER=$1

sudo a2dissite $USER.wezeo.fail.conf 2>/dev/null
sudo a2dissite $USER.wezeo.fail-le-ssl.conf 


sudo systemctl reload apache2

sudo certbot delete --cert-name $USER.wezeo.fail

rm /etc/apache2/sites-available/$USER.wezeo.fail.conf
rm /etc/apache2/sites-available/$USER.wezeo.fail-le-ssl.conf

rm /etc/apache2/sites-enabled/$USER.wezeo.fail.conf
rm /etc/apache2/sites-enabled/$USER.wezeo.fail-le-ssl.conf