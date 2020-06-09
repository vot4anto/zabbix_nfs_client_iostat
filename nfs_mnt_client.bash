#!/usr/bin/env bash
#the output of stat (or rpcinfo) when the target is not available and the command hangs for a few minutes before it would time out on its own. 
#While [ -d /some/mountpoint ] can be used to detect a stale mountpoint, there is no similar alternative for rpcinfo
#and hence use of read -t1 redirection is the best option. The output from the subshell can be muted with 2>&-. Here is an example from`
# a $REPLY string having content is a success, not a failure. Thus, an empty $REPLY string means the mount is stale. Thus, the conditional should use -z, not -n:
mountpoint=$1
read -t1 < <(stat -t "$mountpoint" 2>&-)
if [ -z "$REPLY" ] ; then
  echo "NFS mount stale. Check status..."
  #umount -f -l "$mountpoint"
fi
