#!/usr/bin/env bash

DISK_RECORD=$(iostat -k | grep sda)

DISK_READ=$(echo ${DISK_RECORD} | awk '{print$3}')
DISK_WRITE=$(echo ${DISK_RECORD} | awk '{print$4}')

#echo "date|"$(date +%F" "%T)"|DISK READ (kB/s)|"${DISK_READ}"|DISK WRITE (kB/s)|"${DISK_WRITE} > /home/Hybrid-Cloud-Monitor/monitor-data/ioMetric.data

echo "date|"$(date +%F" "%T)"|DISK READ (kB/s)|"${DISK_READ}"|DISK WRITE (kB/s)|"${DISK_WRITE} >> /home/Hybrid-Cloud-Monitor/monitor-data/ioMetric_history.csv

exit 0
