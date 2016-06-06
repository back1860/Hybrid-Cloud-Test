#!/usr/bin/env bash

. /root/adminrc

DIR=`cd "$(dirname "$0")"; pwd`
RESULT_LOG=${DIR}/create_vms_extent.log

echo " " >> ${RESULT_LOG}
echo "======================================================================" >> ${RESULT_LOG}
echo "start crate vms test, date: "$(date +%F" "%T) >> ${RESULT_LOG}
for ((i=1;i<=5;i++))
do
    echo "batch: ${i}-------------------------------------------------------" >> ${RESULT_LOG}
    echo "create 100 vms, start,   date: "$(date +%F" "%T) >> ${RESULT_LOG}
    for ((j=1;j<=100;j++))
    do
        sh create_vm_single.sh ${j} ${i} >  /dev/null 2>&1 &
    done
 
    sleep 120s
   
    > nova-list.temp
    nova list > nova-list.temp
    temp=`cat nova-list.temp | grep 'BUILD'`
    while [ -n "${temp}" ];
    do
        sleep 10s
        > nova-list.temp
        nova list > nova-list.temp
        temp=`cat nova-list.temp | grep 'BUILD'`
    done
 
    echo "create 100 vms, success, date: "$(date +%F" "%T) >> ${RESULT_LOG}
    sleep 120s

    > nova-list.temp
    nova list > nova-list.temp
    temp=`cat nova-list.temp`

    for k in {1..20}
    do
        if [ -n "${temp}" ]; then
            break
        else
            if [ ${k} -eq 20 ]; then
                exit 127
            fi
            sleep 30s
            > nova-list.temp
            nova list > nova-list.temp
            temp=`cat nova-list.temp`
        fi
    done

    ACTIVE_NUM=`cat nova-list.temp | grep 'ACTIVE' | wc -l`
    ERROR_NUM=`cat nova-list.temp | grep 'ERROR' | wc -l`
    RUNNING_NUM=`cat nova-list.temp | grep 'Running' | wc -l`
    NOSTATE_NUM=`cat nova-list.temp | grep 'NOSTATE' | wc -l`
    echo "active vms: "${ACTIVE_NUM} >> ${RESULT_LOG}
    echo "error vms: "${ERROR_NUM} >> ${RESULT_LOG}
    echo "running vms: "${RUNNING_NUM} >> ${RESULT_LOG}
    echo "nostate vms: "${NOSTATE_NUM} >> ${RESULT_LOG}

    > nova-list.temp
    sleep 10s
done

echo "finish crate vms test, date: "$(date +%F" "%T) >> ${RESULT_LOG}
echo "======================================================================" >> ${RESULT_LOG}

echo " " >> ${RESULT_LOG}
echo "steady state==========================================================" >> ${RESULT_LOG}
while true
do
    echo "date: "$(date +%F" "%T)"-----------------------------------------" >> ${RESULT_LOG}

    > nova-list.temp
    nova list > nova-list.temp
    temp=`cat nova-list.temp`

    for i in {1..20}
    do
        if [ -n "${temp}" ]; then
            break
        else
            if [ ${i} -eq 20 ]; then
                exit 127
            fi
            sleep 30s
            > nova-list.temp
            nova list > nova-list.temp
            temp=`cat nova-list.temp`
        fi
    done

    ACTIVE_NUM=`cat nova-list.temp | grep 'ACTIVE' | wc -l`
    ERROR_NUM=`cat nova-list.temp | grep 'ERROR' | wc -l`
    RUNNING_NUM=`cat nova-list.temp | grep 'Running' | wc -l`
    NOSTATE_NUM=`cat nova-list.temp | grep 'NOSTATE' | wc -l`
    echo "active vms: "${ACTIVE_NUM} >> ${RESULT_LOG}
    echo "error vms: "${ERROR_NUM} >> ${RESULT_LOG}
    echo "running vms: "${RUNNING_NUM} >> ${RESULT_LOG}
    echo "nostate vms: "${NOSTATE_NUM} >> ${RESULT_LOG}

    > nova-list.temp
    sleep 60s
done

