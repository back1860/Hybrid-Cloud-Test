#!/usr/bin/env bash

. adminrc_test

DIR=`cd "$(dirname "$0")"; pwd`
RESULT_LOG=${DIR}/show-vms.log

echo " " >> ${RESULT_LOG}
echo "======================================================================" >> ${RESULT_LOG}
echo "start static test, data: "$(date +%F" "%T) >> ${RESULT_LOG}
sleep 720s
echo "start nova show test, date: "$(date +%F" "%T) >> ${RESULT_LOG}
for ((j=1;j<=600;j++))
do
    for ((i=1;i<=20;i++))
    do
        sh nova-show-vm.sh ${i} ${j} >  /dev/null 2>&1 &
    done
    sleep 1s
done

echo "finish crate vms test, date: "$(date +%F" "%T) >> ${RESULT_LOG}
echo "======================================================================" >> ${RESULT_LOG}

exit 0
