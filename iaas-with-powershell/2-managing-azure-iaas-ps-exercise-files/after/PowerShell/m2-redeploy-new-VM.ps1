<#
  Azure VMs with custom Images (Restored from vhd)
  
  * Instructions for Windows: https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/ 
  
  MUST GENERALIZE THE BASE IMAGE BEFORE RESTORE

#>

Import-Module AzureRM

. ./login.ps1

$resourceGroup      = "automation"
$location           = "West Europe"
$storageAccountName = "ms20532"
$vnetName           = "iaas-vnet" 


$VMName             = "win-web-2"

## can take up to 20 minutes 
. .\m2-create-windows-web-app-vm.ps1 -ResourceGroupName $resourceGroup -Location $location -StorageAccountName $storageAccountName -VmName $VMName -VnetName $vnetName  -SubnetIndex 0 
