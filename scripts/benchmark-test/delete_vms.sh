#!/usr/bin/env bash

. /root/adminrc
vm_id=`nova list | grep server | awk -F "|" '{print $2}'`
for id in `echo ${vm_id}`
do
    nova delete ${id}
done

