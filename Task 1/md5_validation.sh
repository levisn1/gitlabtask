#!/bin/bash
cd /home/luis
/home/luis/.rbenv/shims/ruby /var/log/linux_users.rb
sleep 2
if [[ ! -f "/var/log/current_users_hash.txt" ]]                             #If the file current_users_hash doesn't exist --> Create it
then
    echo "creating current_users_hash.txt and user_changes.txt"
    touch /var/log/current_users_hash.txt /var/log/user_changes.txt
fi
md5_users="$(md5sum "/var/log/linux_users.txt" | cut -d' ' -f1)"           #Storing the md5 hash into a variable
if [ -s /var/log/current_users_hash.txt ]                                   #If current_users_hash.txt is not empty,
then
    current_users_hash=`cat /var/log/current_users_hash.txt`            #collect it's content.
    if [ "$md5_users" == "$current_users_hash" ]                   #if the linux users hash match the old one, fine,
    sleep 2
    then
    echo "No changes in the MD5 hash detected"
  else                                                               #otherwise store the new hash into current_users_hash.txt
  echo "$md5_users" > "/var/log/current_users_hash.txt"
  echo "A change occured in the MD5 hash"
  now=$(date +"%m_%d_%Y_%T")                                         #creating a user_changes.txt file that logs the changing
  echo "$now changes occured" > "/var/log/user_changes.txt"
  fi
else
    echo "Storing the MD5 hash into the current_users_hash.txt.."                    #store the linux users hash into the current_users_hash.txt (first script launch)
    echo "$md5_users" > "/var/log/current_users_hash.txt"
fi
