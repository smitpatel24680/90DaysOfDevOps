#!/bin/bash
#
<<help
This is a shell script to create user using -c option
help

permission=$1
#echo "Hello frustrated $permission"


function reset_user_password {
if [ "$permission" = "-r" ]; then
        echo "Permission granted"
        echo "====Will start the user reset password process shortly====="
        read -p "Enter username: " username
        count=$(grep -c $username /etc/passwd)
        if [[ $count == 1 ]]; then
                #sudo passwd $username
                read -p "Enter password: " password
                echo -e "$password\n$password" | sudo passwd "$username"
                echo "====Reset password of user successfully===="
        else
                echo "Username $username does not exists"
        fi
else
        echo "Unauthorized"
fi
}

reset_user_password

