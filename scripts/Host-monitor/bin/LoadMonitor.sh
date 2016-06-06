#!/usr/bin/env bash

LOAD_TEMP=$(uptime | grep "load average")
LOAD=${LOAD_TEMP#*'load average:'}
LOAD_1=$(echo ${LOAD} | awk '{print $1}')
LOAD_5=$(echo ${LOAD} | awk '{print $2}')
LOAD_15=$(echo ${LOAD} | awk '{print $3}')

#echo "date|"$(date +%F" "%T)"|Load Average|"${LOAD_1%%","*}"|Load Average (5min)|"${LOAD_5%%","*}"|Load Average (15min)|"${LOAD_15%%","*} > /home/Hybrid-Cloud-Monitor/monitor-data/loadMetric.data

echo "date|"$(date +%F" "%T)"|Load Average|"${LOAD_1%%","*}"|Load Average (5min)|"${LOAD_5%%","*}"|Load Average (15min)|"${LOAD_15%%","*} >> /home/Hybrid-Cloud-Monitor/monitor-data/loadMetric_history.csv

exit 0
