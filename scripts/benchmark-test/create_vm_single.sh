#!/usr/bin/env bash

VM_NUM=${1}
BATCH_NUM=${2}

DIR=`cd "$(dirname "$0")"; pwd`
RESULT_LOG=${DIR}/log/create_vm_num_${VM_NUM}.log

vmname=server@${BATCH_NUM}-${VM_NUM}
nova show ${vmname}
if [ $? -ne 0 ]; then
    m=0
    echo "create vm ${vmname} start, date: "$(date +%F" "%T) >> ${RESULT_LOG}
    while ! nova boot --flavor m1.small --image test-vm --availability-zone az12.vcloud --nic net-id=8758ff73-7832-4068-b0dd-9684f42ca6ac $vmname
    do 
        if [ $m -gt 90 ]; then
            echo "nova boot ${vmname} failed, exit." >> ${RESULT_LOG}
            exit 127
        fi

        sleep 2
        m=$[m + 1]
    done

    echo "boot vm ${vmname} success, date: "$(date +%F" "%T) >> ${RESULT_LOG}
        
    m=0
    vm_status=`nova show ${vmname} | grep OS-EXT-STS:vm_state | awk -F "|" '{print $3}'`
    vm_status=`echo ${vm_status}`
    while [ "${vm_status}" != "active" ]
    do
        if [ $m -gt 90 ]; then
            echo "boot vm:${vmname} failed, vm status: ${vm_status}" >> ${RESULT_LOG}
            exit 127
        fi

	sleep 5
        vm_status=`nova show ${vmname} | grep OS-EXT-STS:vm_state | awk -F "|" '{print $3}'`
        vm_status=`echo ${vm_status}`
        m=$[m + 1]
    done
    
    echo "boot vm:${vmname} success, vm status: ${vm_status}, date: "$(date +%F" "%T) >> ${RESULT_LOG}
    exit 0
fi
exit 0
