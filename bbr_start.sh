#!/bin/sh

# start BBR
if  [ ! -f "/etc/sysctl.conf.cp" ];then
  sudo cp /etc/sysctl.conf /etc/sysctl.conf.cp
  fi

sudo echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
sudo echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sudo sysctl -p