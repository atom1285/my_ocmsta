#!/bin/sh

set -e

if [ "$1" == "--preset" ]; then
    USER=$2;
else
    echo "Enter the username for this subdomain";
    read USER;
fi

echo "Creating a subdomain for '$USER' ";
exit

# rm /etc/apache2/sites-available/$USER.wezeo.fail.conf  
USER=$USER envsubst < conf_templates/site.conf.tmpl > /etc/apache2/sites-available/$USER.wezeo.fail.conf

if [ ! -f /var/www/$USER.wezeo.fail/index.html ];
then
    sudo USER=$USER envsubst < web_templates/index.html.tmpl > /var/www/$USER.wezeo.fail/index.html
fi

sudo a2dissite $USER.wezeo.fail.conf
sudo a2ensite $USER.wezeo.fail.conf 
sudo systemctl reload apache2

sudo certbot --apache -d $USER.wezeo.fail