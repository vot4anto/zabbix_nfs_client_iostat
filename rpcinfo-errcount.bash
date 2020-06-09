#!/usr/bin/env bash
# This sample script can be used with the zabbix to set-up monitoring of nfs service availability
# NAME: rpccount

ERROR_COUNT=0
ERROR_DETAILS=""
for line in $(/usr/sbin/rpcinfo -p $1 | grep -v program | tr -s ' ' | cut -d' ' -f2- | sort -u | sed 's/ /,/g');
do
	program=`echo $line | cut -d',' -f1`
	version=`echo $line | cut -d',' -f2`
	port=`echo $line | cut -d',' -f4`
	service=`echo $line | cut -d',' -f5`
	rpcCmd=`/usr/sbin/rpcinfo -n $port -u $1 $program $version 2>&1 >/dev/null`
	if [ ! "$rpcCmd" = "" ]; then
		ERROR_COUNT=$((ERROR_COUNT + 1))
		ERROR_DETAILS=`echo "${ERROR_DETAILS}+${service}(${program}) - $rpcCmd"`
	fi
done
echo $ERROR_COUNT
