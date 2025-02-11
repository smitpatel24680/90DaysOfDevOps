#!/bin/bash
#
<<help
This is a shell script to create user using -c option
help

permission=$1
#echo "Hello frustrated $permission"


function delete_user {
if [ "$permission" = "-d" ]; then
        echo "Permission granted"
        echo "====Will start the user deletion process shortly====="
        read -p "Enter username: " username
        count=$(grep -c $username /etc/passwd)
        if [[ $count == 1 ]]; then
                sudo userdel $username
                echo "====Deleted user successfully===="
        else
                echo "Username $username does not exist"
        fi
else
        echo "Unauthorized"
fi
}

delete_user

