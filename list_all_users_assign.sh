#!/bin/bash
#
<<help
This is a shell script to list
all user using -l option
help

permission=$1
#echo "Hello frustrated $permission"


function list_all_user {
if [ "$permission" = "-l" ]; then
        echo "Permission granted"
        cat /etc/passwd | cut -d: -f1,3
else
        echo "Unauthorized"
fi
}

list_all_user

