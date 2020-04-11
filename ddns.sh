#!/usr/bin/env bash

#Update the first 4 variables with your information
set -e

export hostname=$HOSTNAME
echo $hostname
AWS_NAMESERVER="ns-1028.awsdns-00.org"
echo $AWS_ZONEID
CONF_FILE=/usr/local/bin/batch.json
DATE=$(date)
dnsIp=`dig +short "$HOSTNAME" @"$AWS_NAMESERVER"`
if [[ ! $dnsIp =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
then
    echo "Could not get old IP address: $dnsIP"
fi

ret=$(curl -s "http://inet-ip.info/ip")
export currentIp=$(echo $ret | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b")
 echo "currentIp:" $currentIp



if [ "$dnsIp" != "$currentIp" ];
 then
  envsubst < ${CONF_FILE}.template > ${CONF_FILE}

  echo "Changing IP address of $HOSTNAME from $dnsIp to $currentIp"
  aws route53 change-resource-record-sets --hosted-zone-id $AWS_ZONEID --change-batch "file://${CONF_FILE}"

 else
  echo "Nothing to do"
fi

