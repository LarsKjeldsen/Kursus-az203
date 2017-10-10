
## Creating an Azure Virtual Machine

public IP:  13.74.177.10
userName :  jalal
pwd:        AzurePa55w****


## connect using RDP 

From the portal try connect to generate Dev20532.rdp

## Powershell connect using winRM 

```
$IP = 13.74.177.10
$login = new-pssession -computer $ip -credentials jalal 
enter-pssession -pssession $login 


```
