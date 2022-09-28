#!/usr/bin/env bash

iptables.sh

VPNGATE_URL=http://www.vpngate.net/api/iphone/

function global_ip {
  curl -s inet-ip.info
}

# vpn connect func
function connect {
  while :; do 
    echo start
    while read line; do 
	  header=$(echo $line | cut -d ',' -f 1-14)	
	  name=$(echo $line | cut -d ',' -f 1)	
	  echo "$header"
      line=$(echo $line | cut -d ',' -f 15)
      line=$(echo $line | tr -d '\r')
      openvpn <(echo "$line" | base64 -d);
    done < <(curl -s $VPNGATE_URL | grep ",United States,US," | grep -v public-vpn- | sort -t ',' -k5 -n -r | head -5 | sort -R)
    echo end
  done
}

BEFORE_IP="$(global_ip)"

# start proxy
privoxy <(grep -v listen-address /etc/privoxy/config ; echo listen-address  0.0.0.0:8119) &

# connect vpn
connect &

# vpn check

while :; do
  sleep 5
  AFTER_IP=$(global_ip)
  result=$?
  echo "before=$BEFORE_IP after=$AFTER_IP"
  if [ $result -ne 0 ]; then
    pkill openvpn
  elif [ "$BEFORE_IP" = "$AFTER_IP" ]; then
    pkill openvpn
  else 
    sleep 55
  fi
done

