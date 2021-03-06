#!/bin/bash
# This script automatically creates user accounts with random passwords.
# Author: Alf Baez
# Date: 09/14/2019
# ver: 2.0
# updated: 07/28/2020
# -- To resolve a bug around not create ad difference random password for each
# -- users
LOGFILE=/tmp/geekscreated_$(date +%Y%m%d-%H%M).log
# Declare local variables, generate random password.
echo 'Adding new DataSiFi greeks Today's date: $(date +%Y%m%d-%H%M) >> $LOGFILE
# Assumes groups are in place
# If not then add these with groupadd -g 1003 kafka -g 1004 datascience -g 1009 sissyadmins
for u in $( cat scifigeeks.txt ); do
    useradd -m -g datascience -G kafka,wheel -d /home/$u  -c "A DataSiFi Geek" -s /bin/bash $u
    echo "userID:" $u "added successfully!"
    randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9!*#' | fold -w 9 | head -n 1)
    echo $u:$randompw | chpasswd
    echo '=========================================================' >> $LOGFILE
    echo "UserID:" $u "has been created with password:" $randompw >> $LOGFILE
    echo '<-------------------------------------------------------->' >> $LOGFILE
done
