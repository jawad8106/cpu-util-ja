#!/bin/bash

## ATTENTION: CHANGE RCPT variable, it defins who will get email

# TASK
# Write a shell script that generates a report text file, which shows the System info, IP, CPU usage,
# Memory usage and email it to your email address every day at 12:00PM.


usage=$(
		top -l 1 \
			| grep "Cpu(s)" \
			| sed "s/.*, *\([0-9.]*\)%* id.*/\1/" \
			| awk '{print 100 - $1"%"}'
	)
date=$(date +%Y.%m.%d\ %H-%M-%S)
RCPT="root@localhost"


cat << INFO > info.txt
##############
# SYSTEM INFO
##############
$(cat /etc/os-release)
$(lsb_release -a &> /dev/null)
$(hostnamectl)


################
# IP Address
################
$(curl -s api.ipify.org)


############
# CPU Usage
############
$usage

################
# Memory Usage
################
$(top)

INFO


echo "Hello, I am sent from bash script. please see attached file" | mail -s "Daily Report" $RCPT -A info.txt

