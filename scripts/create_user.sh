#!/bin/sh

set -e # sets the scripts as non interactive

while [ True ]; do
if [ "$1" = "--preset" ]; then
    PRESET=true
    shift 1
elif [ "$1" = "--create_subdomain" ]; then
    CREATE_SUBDOMAIN=true
    shift 1
else
    break
fi
done

if [ "$PRESET" = true ]; then
    USER=$1;
    PASSWORD=$2;
    PASSWORD_CONFIRM=$3;

    echo $USER;
    echo $PASSWORD;
    echo $PASSWORD_CONFIRM;
else
    echo "Please enter a username for the new user";
    read USER;

    echo "Please enter a password for the new user";

    stty -echo;
    read PASSWORD;
    stty echo;

    echo "Please enter the password again to confirm it";

    stty -echo;
    read PASSWORD_CONFIRM;
    stty echo;
fi

if [ $PASSWORD != $PASSWORD_CONFIRM ]; then
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

if [ "$CREATE_SUBDOMAIN" = true ]; then
    /bin/bash create_subdomain.sh --preset $USER;
fi