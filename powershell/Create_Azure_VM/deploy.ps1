# Sign in to Azure
# Login-AzureRmAccount


# Select the target subscription
$Subscription_Id        = "TODO"
Select-AzureRmSubscription -SubscriptionID $Subscription_Id;

######################### Global configs 

$location = 'west europe'
$vmSize   = 'Basic_A3'

<#
  
  $vmSize = 'Basic_A0' --> (1 vcpu, 0.75 GB memory)
  $vmSize = 'Basic_A1' --> (1 vcpu, 1.75 GB memory)
  $vmSize = 'Basic_A2' --> (2 vcpu, 3.50 GB memory)
  $vmSize = 'Basic_A3' --> (4 vcpu, 7 GB memory)
  $vmSize = 'Basic_A4' --> (8 vcpu, 14 GB memory)

  $vmSize = 'Standard_A0' ... 'Standard_A8'
  $vmSize = 'Standard_D1' ... 'Standard_D12'
  
#>


<#

# 
  How to find the latest skus image available
  $Windows = '2012-R2-Datacenter'

#>

$Windows = '2016-Datacenter'

$AzureImageSku   = Get-AzureRmVMImage -Location $location -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus $windows
$AzureImageSku   = $AzureImageSku | Sort-Object Version -Descending #put the newest first which is the highest patched version
$skuName_latest  = $AzureImageSku[0] #Newest
$skuName_latest.skus


$NameSpace    = 'kursus'
$rgName       = "$NameSpace-group"
$vmName       = "$NameSpace-vm"

$pubName      = 'MicrosoftWindowsServer'
$offerName    = 'WindowsServer'
$skuName      =  $skuName_latest.skus
$vnetName     = "$NameSpace-vnet"
$vnetPrefix   = '10.1.0.0/20'
$subnetName   = 'default'
$subnetPrefix = '10.1.0.0/24'
$nsgName      = "$vmName-nsg"
$pipName      = "$vmName-ip" 
$nicName      = "$vmName-nic"
$osDiskName   = "$vmName-OsDisk"
$osDiskSize   = 128
$osDiskType   = 'StandardLRS'

#Setup a filter to timestamp logs
filter timestamp {"$(Get-Date -Format G): $_"}

#Create Resources for new deployment
Write-Output "Setting up VM resources and variables" | timestamp

# create a resource group
New-AzureRmResourceGroup -Name $rgName -Location $location

# create a virtual network and a subnet
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig `
      -Name $subnetName `
      -AddressPrefix $subnetPrefix

$vnet = New-AzureRmVirtualNetwork `
      -ResourceGroupName $rgName `
      -Location $location `
      -Name $vnetName `
      -AddressPrefix $vnetPrefix `
      -Subnet $subnetConfig

$subnetId = (Get-AzureRmVirtualNetworkSubnetConfig -Name $subnetName -VirtualNetwork $vnet).Id

# Create admin credentials
$adminUsername = 'Student'
$adminPassword = 'Pa55w.rd1234'
$adminCreds = New-Object PSCredential $adminUsername, ($adminPassword | ConvertTo-SecureString -AsPlainText -Force) 

# Create an network security group (NSG)
$nsgRuleRDP = New-AzureRmNetworkSecurityRuleConfig -Name 'default-allow-rdp' -Protocol Tcp -Direction Inbound -Priority 1000 `
                    -SourceAddressPrefix * -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389 -Access Allow
$nsg = New-AzureRmNetworkSecurityGroup -ResourceGroupName $rgName -Location $location -Name $nsgName -SecurityRules $nsgRuleRDP

# Create a public IP and NIC
$pip = New-AzureRmPublicIpAddress -Name $pipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic 
$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $rgName -Location $location `
      -SubnetId $subnetId -PublicIpAddressId $pip.Id -NetworkSecurityGroupId $nsg.Id

# Set VM Configuration
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize
Add-AzureRmVMNetworkInterface -VM $vmConfig -Id $nic.Id
Set-AzureRmVMOperatingSystem -VM $vmConfig -Windows -ComputerName $vmName -Credential $adminCreds 
Set-AzureRmVMSourceImage -VM $vmConfig -PublisherName $pubName -Offer $offerName -Skus $skuName -Version 'latest'
Set-AzureRmVMOSDisk -VM $vmConfig -Name $osDiskName -DiskSizeInGB $osDiskSize -StorageAccountType $osDiskType -CreateOption fromImage


# Create Virtual Machine
Write-Output "Creating the VM" | timestamp
New-AzureRmVM -ResourceGroupName $rgName -Location $location -VM $vmConfig




$timestamp = (Get-Date).Ticks
Write-Output "Installation complete" | timestamp