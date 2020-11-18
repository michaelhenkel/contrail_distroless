#!/busybox/sh

function loadKmod {
  echo "checking that kernel module is available"
  if [[ -d "/kernelmodules/$(uname -r)" ]]; then
    echo "matching kernel module found"
  else
    echo "no kernel module found for kernel $(uname -r)"
    exit 1
  fi
  echo "checking if kernel module is already loaded"
  lsmod |grep vrouter
  if [[ $? -eq 0 ]]; then
    echo "trying to unload kernel module"
    rmmod vrouter || echo "cannot remove vrouter komod"
  fi
  echo "loading kernel module"
  insmod /kernelmodules/$(uname -r)/vrouter.ko
  if [[ $? -eq 0 ]]; then
    echo "kernel module loaded"
  else
    echo "failed loading kernel module $?"
    exit 1
  fi
}

function getInterfaceFromVhost {
  echo "getting interface from vhost"
  MAC=$(cat /sys/class/net/vhost0/address)
  for i in $(grep ${MAC} /sys/class/net/*/address|awk -F"/" '{print $5}'); do
    if [[ $i != "vhost0" ]]; then
      INTERFACE=$i
      echo "interface ${INTERFACE} linked to vhost"
      break
    fi
  done
}

function getInterfaceFromIP {
  echo "getting interface from ip"
  INTERFACE=$(ip route sh |grep ${PODIP} |awk '{print $3}' |head -1)
}

function getInterfaceFromDefaultRoute {
  echo "getting interface from default route"
  INTERFACE=`cat /proc/net/route | awk '{ if($2 == "00000000") print $1;}'`
}

function getInterfaceIPFromDefaultRoute {
  echo "getting interface ip from default route"
  PODIP=$(ip route get 8.8.8.8 |grep -E -o "src ([0-9]{1,3}[\.]){3}[0-9]{1,3}" |grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}")
}

function getCIDRForIP {
  CIDR=$(ip route show dev $1 |grep "src ${PODIP}" |grep -E -o "(/[0-9]{1,2})"|head -1)
}

function getInterfaceIPs {
  IPS=$(ip address sh dev $1 |grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}/[0-9]{1,2}")
  if [[ -z ${PODIP} ]]; then
    if [[ $(echo ${IPS}| wc -l) -gt 1 ]]; then
      getInterfaceIPFromDefaultRoute
    else
      PODIP=${IPS} |awk -F"/" '{print $1}'
    fi
    [ -z ${PODIP} ] || echo "cannot get ip"; exit 1
  fi
  getCIDRForIP $1
  INTERFACEIP=${PODIP}${CIDR}
}

function dumpRoutingTable {
  ip route show |grep $1 |sed "s/$1/$2/g" > /tmp/contrailroutes
}

function getInterface {
  echo "trying to get interface"
  if [[ -z ${INTERFACE} ]]; then
    ip link sh dev vhost0 2&>1 > /dev/null
    if [[ $? -eq 0 ]]; then
      getInterfaceFromVhost
    fi
    if [[ -z ${INTERFACE} ]]; then
      getInterfaceFromIP      
      if [[ -z ${INTERFACE} ]]; then
        getInterfaceFromDefaultRoute
      fi
    fi
  fi
  if [[ -z ${INTERFACE} ]]; then
    echo "couldn't get interface"
    exit 1
  fi
  echo "found interface ${INTERFACE}"
}

function createVhost {
  ip link sh dev vhost0 2&>1 > /dev/null && resetVhost
  loadKmod
  getInterface
  getInterfaceIPs ${INTERFACE}
  dumpRoutingTable ${INTERFACE} vhost0
  MAC=$(cat /sys/class/net/${INTERFACE}/address)
  ./vif --create vhost0 --mac $MAC
  ./vif --add ${INTERFACE} --mac $MAC --vrf 0 --vhost-phys --type physical
  ./vif --add vhost0 --mac $MAC --vrf 0 --type vhost --xconnect ${INTERFACE}
  ip link set dev vhost0 up
  ip addr del ${INTERFACEIP} dev ${INTERFACE} && \
    ip addr add ${INTERFACEIP} dev vhost0 && \
    ip link set dev vhost0 up && \
    while IFS= read -r line; do ip route add $line 2&>1 > /dev/null ||true; done < /tmp/contrailroutes
}

function resetVhost {
  echo "resetting vhost"
  getInterface
  getInterfaceIPs vhost0
  dumpRoutingTable vhost0 $INTERFACE
  rmmod vrouter && \
    ip addr add ${INTERFACEIP} dev ${INTERFACE} && \
    while IFS= read -r line; do ip route add $line 2&>1 > /dev/null ||true; done < /tmp/contrailroutes
}

case $1 in
	create)
		createVhost
		;;
	reset)
		resetVhost
		;;
esac

