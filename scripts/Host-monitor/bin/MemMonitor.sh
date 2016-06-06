#!/usr/bin/env bash

MEMORY=$(free -m | grep 'Mem')

MEM_RECORD=${MEMORY#*'Mem:'}

TOTAL_MEM=$(echo ${MEM_RECORD} | awk '{print$1}')
USED_MEM=$(echo ${MEM_RECORD} | awk '{print$2}')
BUFFERS_MEM=$(echo ${MEM_RECORD} | awk '{print$5}')
CACHED_MEM=$(echo ${MEM_RECORD} | awk '{print$6}')

USED_NO_BUFFERS=`expr ${USED_MEM} - ${BUFFERS_MEM}`
USED_REAL=`expr ${USED_NO_BUFFERS} - ${CACHED_MEM}`

#MEM_USED_RATE=`expr ${USED_REAL}/${TOTAL_MEM} | bc -l`
#MEM_USED_RATE_LARGE=`expr ${MEM_USED_RATE}*100 | bc -l`
#MEM_USED_RATE_PRINT=`expr "scale=5; ${MEM_USED_RATE_LARGE}/1" | bc`
#
#

#echo "date|"$(date +%F" "%T)"|Mem Used|"${USED_REAL} > /home/Hybrid-Cloud-Monitor/monitor-data/memMetric.data

echo "date|"$(date +%F" "%T)"|Mem Used|"${USED_REAL} >> /home/Hybrid-Cloud-Monitor/monitor-data/memMetric_history.csv

exit 0
