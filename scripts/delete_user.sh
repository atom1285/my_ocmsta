#!/bin/sh

set -e # sets the scripts as non interactive

USER=$1

sudo userdel -f -r $USER 2>/dev/null