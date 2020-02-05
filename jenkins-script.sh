#!/bin/bash

# TASK:
# Write a shell script to create a user Jenkins with user id 4000 and group id 5000 
# and should have root access without password. Script should not run if user already exists.


# CHECK IF "Jenkins" user already exists
count=$(grep -c '^Jenkins:' /etc/passwd)

if [[ $count != 0 ]]; then
	echo "User Jenkins already exists"
	exit 1
fi


groupadd -g 5000 jk 	2> /dev/null


# if Jenkins does not exist then create it
useradd -m -u 4000 -g 5000 -s /bin/bash Jenkins 2> /dev/null

if [[ $? == 0 ]]; then
	usermod -aG sudo Jenkins
else
	echo "Failed to add new user"
fi

echo "Please set password for Jenkins"
passwd Jenkins

exit 0

