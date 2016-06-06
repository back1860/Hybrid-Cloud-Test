#!/usr/bin/env bash

top -d 30 -b -n 2 > /home/monitor/top.tmp
cat /home/monitor/top.tmp | awk  '/%Cpu0/&&b>1{print "us,"$3",sys,"$5",id,"$9}/load average:/&&b++{printf $3","}' >> /home/monitor/data/cpu_history.csv

cat /home/monitor/top.tmp | awk  '/Mem:/&&b>1{print "total,"$3",used,"$5}/load average:/&&b++{printf $3","}' >> /home/monitor/data/mem_history.csv

cat /home/monitor/top.tmp | awk 'b>1&&/ovs/{
	print d"RES,"$6",%CPU,"$9",%MEM,"$10",COMMAND,"$NF
}/load average:/&&b++{d=$3","}' >> /home/monitor/data/ovs_history.csv

cat /home/monitor/top.tmp | awk 'b>1&&/neutron/{
	print d"RES,"$6",%CPU,"$9",%MEM,"$10",COMMAND,"$NF
}/load average:/&&b++{d=$3","}' >> /home/monitor/data/neutron_history.csv

cat /home/monitor/top.tmp | awk 'b>1&&/wormhole/{
	print d"RES,"$6",%CPU,"$9",%MEM,"$10",COMMAND,"$NF
}/load average:/&&b++{d=$3","}' >> /home/monitor/data/wormhole_history.csv

