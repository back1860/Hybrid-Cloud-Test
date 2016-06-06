#!/usr/bin/env bash

CPU_TIME_NEW=$(cat /proc/stat | grep 'cpu' | awk '{print $2" "$3" "$4" "$5" "$6" "$7" "$8}')

if [ ! -s /home/Hybrid-Cloud-Monitor/CPU_TIME_LAST ];
then
    echo ${CPU_TIME_NEW} > /home/Hybrid-Cloud-Monitor/CPU_TIME_LAST
    exit 0
fi

CPU_TIME_LAST=$(cat /home/Hybrid-Cloud-Monitor/CPU_TIME_LAST)

IDLE_LAST=$(echo ${CPU_TIME_LAST} | awk '{print $4}')
TOTAL_LAST=$(echo ${CPU_TIME_LAST} | awk '{print $1+$2+$3+$4+$5+$6+$7}')

echo ${CPU_TIME_NEW} > /home/Hybrid-Cloud-Monitor/CPU_TIME_LAST

IDLE_NEW=$(echo ${CPU_TIME_NEW} | awk '{print $4}')
TOTAL_NEW=$(echo ${CPU_TIME_NEW} | awk '{print $1+$2+$3+$4+$5+$6+$7}')

IDLE=`expr ${IDLE_NEW} - ${IDLE_LAST}`
TOTAL=`expr ${TOTAL_NEW} - ${TOTAL_LAST}`
USE=`expr ${TOTAL} - ${IDLE}`

USE_RATE=`expr ${USE}/${TOTAL} | bc -l`
USE_RATE_LARGE=`expr ${USE_RATE}*100 | bc -l`
DISP_USE_RATE=`expr "scale=5; ${USE_RATE_LARGE}/1" | bc`

#echo "date|"$(date +%F" "%T)"|CPU Utilization|"${DISP_USE_RATE} > /home/Hybrid-Cloud-Monitor/monitor-data/cpuMetric.csv

echo "date|"$(date +%F" "%T)"|CPU Utilization|"${DISP_USE_RATE} >> /home/Hybrid-Cloud-Monitor/monitor-data/cpuMetric_history.csv

exit 0
