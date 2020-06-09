#!/usr/bin/env bash
# This sample script can be used with the KM to set-up monitoring of nfs service availability
#==================================================================================================
# rpcinfo is used to collect data on all the connections made to RPC servers.
# 1st all the programs are collected as per given remote host.
# then the script iterate over all the programs to see, if those experience issues.
# The number of failing connections (rpcinfo print those to STDERR, where others are reported to STDOUT), is the value the KM is monitoring on.
# when the value is greater then 0, then annotation describe the found failures.
# when used within a policy, the user is required to specify a given host to run on,
# The following sample settings can be used with the script:
# Name: RPCAvailability
# Script path: /tmp/rpcinfo-monitor.sh
# Script argument: <some storage system on the network which export file systems for NFS usage>
# remaining settings can be used with default values

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
if [ $ERROR_COUNT -gt 0 ]; then
	echo $ERROR_DETAILS | tr '+' '\n'
fi
