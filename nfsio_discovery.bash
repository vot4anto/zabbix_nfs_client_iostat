#!/usr/bin/env bash
# ============================================================
# use env instead of bash
# Modified: 2018-01-10 
# Description: Discovery NFS mountpoints.
#
# Parameters:
#
# NONE
#
# ===========================================================

#array="$(findmnt -lo target -n -t nfs,nfs4)"
#find only nfsv4 
array="$(findmnt -lo target -n -t nfs4)"

comma=""
printf '%s' '{"data":['

while IFS= read -r line ; do
        printf '%s' "$comma{\"{#MOUNT_POINT}\":\"$line\"}"
        comma=","
done <<< "$array"

printf '%s' ']}'





