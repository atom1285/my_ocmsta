#!/bin/sh

set -e # sets the scripts as non interactive

USER=$1
PASSWD=$2
PASSWD_CONFIRM=$3

if [ $PASSWD != $PASSWD_CONFIRM ]; then
    echo "Passwords do not match"
    exit 1
fi

ENCRYPTED_PASSWD=$(perl -e 'print crypt($ARGV[0], "password")' $PASSWD)

sudo useradd -p $ENCRYPTED_PASSWD $USER
sudo usermod -G subdomain_users $USER

#create directorys
mkdir /var/www/$USER.wezeo.fail 
sudo sudo usermod -d /var/www/$USER.wezeo.fail $USER

#set directory permissions
sudo chown -R $USER:subdomain_users /var/www/$USER.wezeo.fail
sudo chmod -R 775 /var/www/$USER.wezeo.fail
sudo chmod -R ugo+rw /var/www/$USER.wezeo.fail