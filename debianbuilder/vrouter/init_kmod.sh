#!/bin/sh
function failed {
  echo "failed adding kernel module"
}
insmod /kernelmodules/$(uname -r)/vrouter.ko || failed
[ -n "$(dmesg | grep -o 'vrouter')" ] || failed
if [[ -z ${INTERFACE} ]]; then
  INTERFACE=`cat /proc/net/route | awk '{ if($2 == "00000000") print $1;}'`
fi
mac=$(cat /sys/class/net/${INTERFACE}/address)
./vif --create vhost0 --mac $mac
./vif --add ${INTERFACE} --mac $mac --vrf 0 --vhost-phys --type physical
./vif --add vhost0 --mac $mac --vrf 0 --type vhost --xconnect ${INTERFACE}
ip link set dev vhost0 up
dev_route=$(ip route get 8.8.8.8 |grep "8.8.8.8 via" |awk '{print $3}')
ip route show |grep ${INTERFACE} |sed "s/${INTERFACE}/vhost0/" > /tmp/contrailroutes
eth0_ip=$(ip a sh dev ${INTERFACE} |grep "inet "|awk '{print $2}')
ip addr del ${eth0_ip} dev ${INTERFACE}
ip addr add ${eth0_ip} dev vhost0
while IFS= read -r line; do
  ip route add $line
done < /tmp/contrailroutes
