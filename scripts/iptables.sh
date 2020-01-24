#/bin/bash
servers_ips=$1
office_ips=$2
home_ips=$3
final_dynamic_ips=$servers_ips,$office_ips,$home_ips
echo Dynamic ips: $final_dynamic_ips

#iptables -A INPUT -s $final_dynamic_ips -j ACCEPT
#iptables -A OUTPUT -d $final_dynamic_ips -j ACCEPT
#iptables -P INPUT DROP
#iptables -P OUTPUT DROP
#service iptables save
#service iptables restart

