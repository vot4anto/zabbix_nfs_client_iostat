# Zabbix LLD Template for NFS client iostat statistics


> Version 1.1 Forker - (20200608)

for Zabbix 4.4
zabbix-agent must be installed on the monitored node
iostat packet MUST be installed


## Install

* copy nfsio_perf.sh anf nfsio_discovery.sh into /etc/zabbix/bin
* copy userparameter_nfsio.conf into /etc/zabbix/zabbix_agent.d
* inport Template 
* restart zabbix_agent

## Files

* nfsio_discovery.sh - LLD for NFS mountpoints autodiscovery  
* nfsio_perf.sh - collect metrics
* template_nfsio.xml - Zabbix template 
* userparameter_nfsio.conf - Zabbix userparameters file

## References

* yumaojun03/zabbix_monitor - https://github.com/yumaojun03/zabbix_monitor
* pdacity/zabbix_nfs_client_iostat https://github.com/pdacity/zabbix_nfs_client_iostat

## Version

* 1.0 release from forked repo and playbook ansible for automation of use of template on monitored node
