#!/bin/sh

if [ "$1" == "--preset" ]; then
    USER=$2;
    $NEW_PASSWORD=$3;
    $NEW_PASSWORD_CONFIRM=$4;
else
    echo "Which user's password would you like to reset?";
    read USER;

    echo "Please enter a new password for the user";
    stty -echo;
    read NEW_PASSWORD;
    stty echo;
    
    echo "Please enter the password again to confirm it";
    stty -echo;
    read NEW_PASSWORD_CONFIRM;
    stty echo;

    if [ $NEW_PASSWORD != $NEW_PASSWORD_CONFIRM ]; then
        echo "Passwords do not match"
        exit 1
    fi
    
    echo -e "$NEW_PASSWORD\n$NEW_PASSWORD_CONFIRM" | sudo passwd $USER  

fi
