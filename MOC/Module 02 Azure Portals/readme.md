
## Best Practices for Microsoft Learning Azure Pass Usage:

```
Check the dollar balance of you Azure Pass within Microsoft Azure once you have set up your subscription, and be aware of how much you are consuming as you proceed through the labs

Do not allow Microsoft Azure components to run overnight or for extended periods. Scripts are run at the end of each lab to remove unneeded services in Azure to prevent unnecessary charges against the subscription.

Remove any Microsoft Azure–created components or services such as storage, virtual machines, or cloud services, after you finish your lab to help minimize cost usage and extend the life of your Microsoft Learning Azure Pass. Scripts are run at the end of each lab to remove unneeded services in Azure to prevent unnecessary charges against the subscription.


Nu kan du få 12 måneders gratis adgang til populære produkter.
https://azure.microsoft.com/da-dk/free/

```


## Virtual Machines 


```Powershell

Get-Module PowerShellGet -list | Select-Object Name,Version,Path

# Install the Azure Resource Manager modules from the PowerShell Gallery

sudo Install-Module AzureRM -force 

# import before use
Import-Module AzureRM

MS0532 $ Login-AzureRmAccount

Account          : jalal.hejazi@gmail.com
SubscriptionName : Betalt efter forbrug
Environment      : AzureCloud


Get-AzureRmVMSize -location NorthEurope

```


## Migration VM to Azure (can take few hours...)

```
Man kan tag on-promises VM og upload til cloud (only .vhd)

OBS: Ensure that the virtual machines are of fixed size

Uploading a virtual hard disk to Azure typically requires that you temporarily open the port 3389 (Remote Desktop Protocol) in Windows Firewall to allow remote desktop connections to the target VM after upload.

```

## Migration VM to Azure using powershell 

```
Først klargøre VM:

1) Connect using Remote desktop 

2) C:\Windows\System32\Sysprep\sysprep.exe 

```


```
Login-AzureRMAccount 

Get-AzureRMStorageAccountKey -ResourceGroupName demos -name ncgdemos

$context = New-AzureStorageContext -StorageAccountName ncgdemos -StorageAccountKey "secret****"
$vhdUrl  = "https://ncgdemos.blob.core.windows.net/vhds/win10os.vhd"
$file    = "C:\Images\Win10os.vhd"

Add-AzureRMVhd -ResourceGroupName "demos" -Destination $vhdUrl -LocalFilePath $file 


```


