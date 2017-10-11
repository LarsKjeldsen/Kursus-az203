
## Powershell getting started with Azure automation


using scoop.sh for installing sudo and powershell to install AzureRM

```
sudo <runas admin command>


```

## get-help updated 

```
Update-Help -Force -ErrorAction SilentlyContinue
```



```
Get-Module PowerShellGet -list | Select-Object Name,Version,Path

# Install the Azure Resource Manager modules from the PowerShell Gallery
sudo Install-Module AzureRM -force 


Import-Module AzureRM

Login-AzureRmAccount

Get-AzureRmVMSize -location NorthEurope

```

