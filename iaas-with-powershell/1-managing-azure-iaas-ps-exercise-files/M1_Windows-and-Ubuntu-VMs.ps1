<### 

    Vision: Create Virtual Machines for Windows and Linux using automation script only

    Design By: Jalal Hejazi MCT & Cloud Architect 2017/10/24

    Cmdlets used in this solution is:


    Import-Module AzureRM
    Login-AzureRmAccount 
    Select-AzureRmSubscription
    
    New-AzureRmResourceGroup
    New-AzureRmStorageAccount
    New-AzureRmVirtualNetworkSubnetConfig
    New-AzureRmVirtualNetwork
    New-AzureRmPublicIpAddress
    New-AzureRmNetworkInterface
    New-AzureRmVMConfig
    New-AzureRmVM

    Set-AzureRmVMOperatingSystem
    Set-AzureRmVMSourceImage
    Set-AzureRmVMOSDisk

    Add-AzureRmVMNetworkInterface
    
    Stop-AzureRmVM 
    Start-AzureRmVM 

    Get-Credential
    Get-AzureRmStorageAccount
    Get-AzureRmPublicIpAddress
    Get-AzureRmVMImageSku
    Get-AzureRmResourceGroup

    Remove-AzureRmResourceGroup

    mstsc

    ssh

#>




Import-Module AzureRM


##############################################################
. ./login.ps1
################################################################


<#
    resourceGroup is the root (top-level) namespace where you can design your IaaS resources. 
    Anything you create like [Storage, VMs, Services, etc.] will be created under the resourceGroup
    
    must be unique   
#>

$resourceGroup  = "automation"



<#
    location is the datacenter region 
    From Denmark the best datacenter is west Europe because of the availability of Azure SQL Databases resources
#>

$location       = "West Europe"

<#
    $RG = Get-AzureRmResourceGroup -Name $resourceGroup  -Location $location
    Remove-AzureRmResourceGroup -Id $rg.ResourceId -Force 
#>


New-AzureRmResourceGroup -Name $resourceGroup -Location $location

$storageAccountName = "ms20532"
New-AzureRmStorageAccount -Name $storageAccountName -ResourceGroupName $resourceGroup `
                          -Type Standard_LRS -Location $location

<# For more information about StorageAccount and REST API HTTP Request/Response information

 Get-AzureRmStorageAccount -Debug -ResourceGroupName $resourceGroup -Name $storageAccountName >> ./storageInfo.md 

#>



$vnetName = "iaas-net" 
$subnet=New-AzureRmVirtualNetworkSubnetConfig -Name frontendSubnet -AddressPrefix 10.0.1.0/24
$vnet = New-AzureRmVirtualNetwork -Name $vnetName -ResourceGroupName $resourceGroup -Location $location `
                                  -AddressPrefix 10.0.0.0/16 -Subnet $subnet

#Windows Server
$nicName="vm1-nic"
$pip = New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $resourceGroup `
                                  -Location $location -AllocationMethod Dynamic
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $resourceGroup `
                                   -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

$vmName = "win-web"
$vm = New-AzureRmVMConfig -VMName $vmName -VMSize "Basic_A1"

$cred=Get-Credential -Message "Admin credentials"
$vm=Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $vmName -Credential $cred `
                                 -ProvisionVMAgent -EnableAutoUpdate
$vm=Set-AzureRmVMSourceImage -VM $vm -PublisherName "MicrosoftWindowsServer" `
                             -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version "latest"

$vm=Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$diskName="os-disk"
$storageAcc=Get-AzureRmStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName
$osDiskUri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage



####################################################################################
## provisioning Windows-VM 
## take few minutes ... 

New-AzureRmVM -ResourceGroupName $resourceGroup -Location $location -VM $vm

####################################################################################













#Linux Server

function Get-ubuntu-sku { 
    Get-AzureRmVMImageSku -Location $location -PublisherName 'Canonical' -Offer 'UbuntuServer' |
    Select skus      | 
    sort skus -desc
}

Get-ubuntu-sku

$ubuntu_distro =  "14.04.3-LTS"
$nic2Name      =  "vm2-nic"
$VM_Size       =  "Basic_A1"

$pip2 = New-AzureRmPublicIpAddress -Name $nic2Name -ResourceGroupName $resourceGroup `
                                   -Location $location -AllocationMethod Dynamic
$nic2 = New-AzureRmNetworkInterface -Name $nic2Name -ResourceGroupName $resourceGroup `
                                    -Location $location -SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip2.Id

$vm2Name = "ub-proxy"
$vm2 = New-AzureRmVMConfig -VMName $vm2Name -VMSize $VM_Size

$cred2=Get-Credential -Message "Admin credentials"
$vm2=Set-AzureRmVMOperatingSystem -VM $vm2 -Linux  -ComputerName $vm2Name -Credential $cred2 
$vm2=Set-AzureRmVMSourceImage -VM $vm2 -PublisherName "Canonical" `
                             -Offer "UbuntuServer" -Skus $ubuntu_distro -Version "latest"

$vm2=Add-AzureRmVMNetworkInterface -VM $vm2 -Id $nic2.Id

$disk2Name="ub-os-disk"
$storageAcc=Get-AzureRmStorageAccount -ResourceGroupName $resourceGroup -Name $storageAccountName
$osDisk2Uri=$storageAcc.PrimaryEndpoints.Blob.ToString() + "vhds/" + $disk2Name  + ".vhd"
$vm2=Set-AzureRmVMOSDisk -VM $vm2 -Name $disk2Name -VhdUri $osDisk2Uri -CreateOption fromImage





####################################################################################
## provisioning Linux-VM 

New-AzureRmVM -ResourceGroupName $resourceGroup -Location $location -VM $vm2

####################################################################################








<# ###################### REMOTE ACCESS to Windows ####################

# windows-OS remote access using [RDP, PSremoting]

mstsc /?  

#>

function Windows-remote-IP {   
    $Public_IP_Address_Windows_VM =  Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Name $nicName
    $Public_IP_Address_Windows_VM.IpAddress

}

function stop-Windows-VM    {  Stop-AzureRmVM  -Name $vmName -ResourceGroupName $resourceGroup -Force  }
function start-Windows-VM   {  Start-AzureRmVM -Name $vmName -ResourceGroupName $resourceGroup   }
function connect-Windows-VM {  mstsc /v:13.69.72.249 /admin /fullscreen  }




<# ###################### REMOTE ACCESS to Linux ####################

# LINUX-OS remote access using [SSH]

#>


function linux-remote-IP {   

    $Public_IP_Address_Linux_VM   = Get-AzureRmPublicIpAddress -ResourceGroupName $resourceGroup -Name $nic2Name
    $Public_IP_Address_Linux_VM.IpAddress
}


function stop-Linux-VM    {  Stop-AzureRmVM  -Name $vm2Name -ResourceGroupName $resourceGroup -Force  }
function start-Linux-VM   {  Start-AzureRmVM -Name $vm2Name -ResourceGroupName $resourceGroup  }
function connect-Linux-VM {  ssh jalal@52.236.160.144  }

start-Linux-VM





<# #########################################################################
    Azure Iaas Charges you for Virtuan machine and windows license fee
    Basic A1 Windows with 1 core, 1.75GB ( ~$55 /month )
    
    * bring your own licens to Azure 
    * Best practice is to shutdown all the VM when not in use

#> 






function remove-ResourceGroup {
    # To clean up and remove everything. just delete the $resourceGroup   
  
    $RG = Get-AzureRmResourceGroup -Name $resourceGroup  -Location $location
  
    Remove-AzureRmResourceGroup -Id $rg.ResourceId -Force -WhatIf
}

remove-ResourceGroup


