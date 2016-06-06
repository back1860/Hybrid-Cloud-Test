#!/usr/bin/env bash

API_RX=$(cat /sys/class/net/external_api/statistics/rx_bytes)
API_TX=$(cat /sys/class/net/external_api/statistics/tx_bytes)

BASE_RX=$(cat /sys/class/net/eth0/statistics/rx_bytes)
BASE_TX=$(cat /sys/class/net/eth0/statistics/tx_bytes)

DATA_RX=$(cat /sys/class/net/tunnel_bearing/statistics/rx_bytes)
DATA_TX=$(cat /sys/class/net/tunnel_bearing/statistics/tx_bytes)

#echo "date|"$(date +%F" "%T)"|API RX(bytes)|"${API_RX}"|API TX(bytes)|"${API_TX}"|BASE RX(bytes)|"${BASE_RX}"|BASE TX(bytes)|"${BASE_TX}"|DATA RX(bytes)|"${DATA_RX}"|DATA TX(bytes)|"${DATA_TX} > /home/Hybrid-Cloud-Monitor/monitor-data/netMetric.data

echo "date|"$(date +%F" "%T)"|API RX(bytes)|"${API_RX}"|API TX(bytes)|"${API_TX}"|BASE RX(bytes)|"${BASE_RX}"|BASE TX(bytes)|"${BASE_TX}"|DATA RX(bytes)|"${DATA_RX}"|DATA TX(bytes)|"${DATA_TX} >> /home/Hybrid-Cloud-Monitor/monitor-data/netMetric_history.csv

exit 0
