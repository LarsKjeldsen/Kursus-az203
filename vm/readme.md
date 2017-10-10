
## Azure Virtual Machine login information 

public IP:  13.74.177.10
userName :  jalal
pwd:        AzurePa55w****


## connect using RDP 

From the portal try connect to generate Dev20532.rdp


## Powershell connect using winRM 

```
$PC = 13.74.177.10
$login = new-pssession -ComputerName $PC -Credential jalal
enter-pssession -pssession $login 


```


## help about_Remote_Troubleshooting

```
WinRm TODO:  

Connecting to remote server 13.74.177.10 failed with the following error message : WinRM kan ikke fuldføre handlingen. Kontrollér, at det angivne computernavn er gyldigt, at computeren kan nås via netværket, at der er aktiveret en firewallundtagelse for tjenesten WinRM, og at den tillader adgang fra denne computer. Som standard begrænser WinRM-firewallundtagelsen for offentlige profiler adgangen til fjerncomputere på samme lokale undernet. For more information, see the about_Remote_Troubleshooting Help topic.

```