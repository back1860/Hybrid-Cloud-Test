service cron stop
ps -ef | grep '/home/Hybrid-Cloud-Monitor/bin' | awk '{print $2}' | xargs kill -9
sleep 5s
sh clear.sh
crontab crontab.template
service cron start
