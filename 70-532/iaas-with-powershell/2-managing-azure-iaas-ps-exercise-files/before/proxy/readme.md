## Setup Nginx as reverse proxy 


* https://jalal.hejazi.dk/



```
scp ./proxy jalal@<IP>:~
ssh jalal@<IP>

sudo cp ./proxy /etc/nginx/sites-available/proxy
sudo ln -s /etc/nginx/sites-available/proxy /etc/nginx/sites-enabled/

sudo rm /etc/nginx/sites-enabled/default

sudo service nginx status 
sudo service nginx restart 

```



## HTTP Response status

502 Bad Gateway (If windows-VM is offline)

```
see the log to understand why 

tail /var/log/nginx/error.log

```


## Generalize the linux image using waagent 

```
sudo waagent -deprovision+user  


jalal@ub-proxy:~$ sudo waagent -deprovision+user
WARNING! The waagent service will be stopped.
WARNING! All SSH host key pairs will be deleted.
WARNING! Cached DHCP leases will be deleted.
WARNING! Nameserver configuration in /etc/resolvconf/resolv.conf.d/{tail,original} will be deleted.
WARNING! jalal account and entire home directory will be deleted.
WARNING! ssh jalal@<IP> is therefor not available, the user jalal is deleted 

:-) 

```
