#!/bin/sh

IGNORE_IP_DIR="${IGNORE_IP_DIR:-./ips}"
echo $IGNORE_IP_DIR

# iptables -F
# iptables -X
# iptables -t nat -F
# iptables -t nat -X

# Create new chain
iptables -t nat -N REDSOCKS

for ip_file in $(ls $IGNORE_IP_DIR); do
  for ip in $(cat $IGNORE_IP_DIR/$ip_file | grep -vE '#'); do
    echo "ignore ip: $ip"
    iptables -t nat -A REDSOCKS -d $ip -j RETURN
  done
done

iptables -t nat -A REDSOCKS -p tcp -j REDIRECT --to-port 12345 
iptables -t nat -A REDSOCKS -p udp -j REDIRECT --to-port 10053 
iptables -t nat -A PREROUTING -p tcp -j REDSOCKS
iptables -t nat -A OUTPUT -p tcp -j REDSOCKS

service iptables save
cp /etc/iptables/rules-save /etc/iptables/rules-save_origin
# rc-update add iptables boot
