<#
  Azure VMs with custom Images and load-balanced 

  2 subnets for windows and linux separated

#>

Import-Module AzureRM

. ./login.ps1

$resourceGroup = "automation"
$location = "West Europe"
$storageAccountName = "ms20532"

$vnetName = "iaas-vnet" 
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location -AddressPrefix 10.0.0.0/16 -Force

$internalLbName = "iaas-lb-internal"


# Create Load balancer
. .\m2-create-subnet-internal.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                  -VnetName $vnetName -SubnetIndex 0 `
                                  -LoadBalancerName $internalLbName -AddressPrefix 10.0.1.0/24


# Availability set
$aSetInternal = New-AzureRmAvailabilitySet -ResourceGroupName $resourceGroup -Location $location `
                                           -Name "iaas-aset-internal"


# Create multiple windows VMs 

For ($i=0; $i -lt 3; $i++) {

    . .\m2-create-windows-web-app-vm.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                         -StorageAccountName $storageAccountName -VmName "win-web-$i" `
                                         -VnetName $vnetName -SubnetIndex 0 `
                                         -AvailabilitySetId $aSetInternal.Id -LoadBalancerName $internalLbName


    #test once 
    . .\m2-create-windows-web-app-vm.ps1 -ResourceGroupName $resourceGroup -Location $location `
        -StorageAccountName $storageAccountName -VmName "win-web-0" `
        -VnetName $vnetName -SubnetIndex 0 `
        -AvailabilitySetId $aSetInternal.Id -LoadBalancerName $internalLbName
}

$publicLbName = "iaas-lb-public"

. .\m2-create-subnet-public.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                -VnetName $vnetName -SubnetIndex 1 `
                                -LoadBalancerName $publicLbName -AddressPrefix 10.0.2.0/24

$aSetPublic = New-AzureRmAvailabilitySet -ResourceGroupName $resourceGroup -Location $location `
                                         -Name "iaas-aset-public"

For ($i=0; $i -lt 2; $i++) {

    . .\m2-create-linux-proxy-vm.ps1 -ResourceGroupName $resourceGroup -Location $location `
                                     -StorageAccountName $storageAccountName -VmName "ub-proxy-$i" `
                                     -VnetName $vnetName -SubnetIndex 1 `
                                     -AvailabilitySetId $aSetPublic.Id -LoadBalancerName $publicLbName
}

