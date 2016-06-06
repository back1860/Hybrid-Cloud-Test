#!/usr/bin/env bash

i=${1}
j=${2}
vm_num=`expr ${i} % 10`
batch_num=`expr ${j} % 30`

DIR=`cd "$(dirname "$0")"; pwd`

RESULT_LOG=${DIR}/nova_show_log.csv

vmname=server@az11-${batch_num}-${vm_num}
start_time=$(date +%F" "%T)
nova show ${vmname}
#sleep 2s
end_time=$(date +%F" "%T)
echo "nova show ${vmname} ,"${start_time}","${end_time} >> ${RESULT_LOG}

exit 0
