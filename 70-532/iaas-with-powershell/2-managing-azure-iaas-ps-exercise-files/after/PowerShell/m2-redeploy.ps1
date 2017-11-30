<#
  Azure VMs with custom Images (Restored from vhd)

  One subnet for windows and linux 

  * Instructions for Windows: https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/ 
  * Instructions for Linux: https://azure.microsoft.com/documentation/articles/virtual-machines-linux-capture-image/ 
  
#>

Import-Module AzureRM

. ./login.ps1

$resourceGroup = "automation"
$location = "West Europe"
$storageAccountName = "ms20532"

$vnetName = "iaas-vnet" 
$subnet   = New-AzureRmVirtualNetworkSubnetConfig -Name frontendsubnet `
                                                  -AddressPrefix 10.0.1.0/24

$vnet = New-AzureRmVirtualNetwork -Name $vnetName `
                                  -ResourceGroupName $resourceGroup `
                                  -Location $location `
                                  -Subnet $subnet `
                                  -AddressPrefix 10.0.0.0/16 -Force

    ## can take up to 20 minutes 
    . .\m2-create-windows-web-app-vm.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                         -StorageAccountName $storageAccountName -VmName "win-web" `
                                         -VnetName $vnetName -SubnetIndex 0 
                                         


    ## can take up to 20 minutes 
    . .\m2-create-linux-proxy-vm.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                     -StorageAccountName $storageAccountName -VmName "ub-proxy" `
                                     -VnetName $vnetName -SubnetIndex 0 
                                     

