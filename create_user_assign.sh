#!/bin/bash
#
<<help
This is a shell script to create user using -c option
help

permission=$1
#echo "Hello frustrated $permission"


function create_user {
if [ "$permission" = "-c" ]; then
	echo "Permission granted"
	echo "====Will start the user creation process shortly====="
	read -p "Enter username: " username
	count=$(grep -c $username /etc/passwd)
	if [[ $count == 0 ]]; then
		sudo useradd -m $username
		read -p "Enter password: " password
		echo -e "$password\n$password" | sudo passwd "$username"
		echo "====Created new user successfully===="
	else
		echo "Username $username already exists"
	fi
else
	echo "Unauthorized"
fi
}

create_user


