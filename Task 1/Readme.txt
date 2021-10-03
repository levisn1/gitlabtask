sudo crontab -e (insert the below string at the bottom)
*/5 * * * * /usr/bin/sh /var/log/md5_validation.sh > /var/log/cron.log
launch the crontab with: sudo systemctl start cron
place the below files in /var/log/
md5_validation.sh destination
linux_users.rb destination
check /var/log/user_changes.txt for linux users changes.
