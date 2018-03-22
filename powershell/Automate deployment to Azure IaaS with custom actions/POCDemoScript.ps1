#Login-AzureRmAccount #ARM logon
#Select-AzureRmSubscription -SubscriptionId <sub>

#Setup a filter to timestamp logs
filter timestamp {"$(Get-Date -Format G): $_"}

#Create Resources for new deployment
Write-Output "Setting up VM resources and variables" | timestamp
$RGName = 'RGUSSCPOC1'
$SAName = 'saussclrspremstor1'
$SASKU = 'Premium_LRS'
$Location = 'southcentralus'

$VirtNetName = 'VNUSSCVNPOC1'

$VMName = '<a unique name>'
$VMSize ="Standard_DS2"
#Get latest image
$AzureImageSku = Get-AzureRmVMImage -Location $Location -PublisherName "MicrosoftWindowsServer" -Offer "WindowsServer" -Skus "2012-R2-Datacenter"
$AzureImageSku = $AzureImageSku | Sort-Object Version -Descending #put the newest first which is the highest patched version
$AzureImage = $AzureImageSku[0] #Newest


#Create Resource Group
New-AzureRmResourceGroup -Name $RGName -Location $Location

#Create Storage Account
New-AzureRmStorageAccount -ResourceGroupName $RGName -StorageAccountName $SAName -Location $Location -Type $SASKU

#Create a Virtual Network
$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name 'StaticSub' -AddressPrefix "10.10.1.0/24"
$vnet = New-AzureRmVirtualNetwork -Force -Name $VirtNetName -ResourceGroupName $RGName `
    -Location $Location -AddressPrefix "10.10.0.0/16" -Subnet $subnet # -DnsServer "10.10.1.10" don't set yet
#If VM points to itself and not offering DNS yet the agents will hang during install

#Create VM
$vm = New-AzureRmVMConfig -VMName $VMName -VMSize $VMSize
#Create NIC
#For demo for easy access give a public IP
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $RGName -Name ('PubIP' + $VMName) `
    -Location $Location -AllocationMethod Dynamic -DomainNameLabel $vmname.ToLower()
$nic = New-AzureRmNetworkInterface -Force -Name ('nic' + $VMName) -ResourceGroupName $RGName `
    -Location $Location -SubnetId $vnet.Subnets[0].Id -PrivateIpAddress 10.10.1.10 `
    -PublicIpAddressId $pip.Id
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$osDiskName = $VMName+'-OSDisk'
$osDiskCaching = 'ReadWrite'
$osDiskVhdUri = "https://$SAName.blob.core.windows.net/vhds/"+$VMName+"-OS.vhd"

# Setup OS & Image
$user = "localadmin"
$password = 'Pa55word'
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($user, $securePassword)  
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $VMName -Credential $cred
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName $AzureImage.PublisherName -Offer $AzureImage.Offer -Skus $AzureImage.Skus -Version $AzureImage.Version
$vm = Set-AzureRmVMOSDisk -VM $vm -VhdUri $osDiskVhdUri -name $osDiskName -CreateOption fromImage -Caching $osDiskCaching

$vm = Set-AzureRmVMBootDiagnostics -VM $vm -Disable

#Add two data disks
$dataDisk1VhdUri = "https://$SAName.blob.core.windows.net/vhds/"+$VMName+"-Data1.vhd"
$dataDisk1Name = $VMName+'-data1Disk'
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDisk1Name -Caching None -CreateOption Empty -DiskSizeInGB 127 -VhdUri $dataDisk1VhdUri -Lun 1
$dataDisk2VhdUri = "https://$SAName.blob.core.windows.net/vhds/"+$VMName+"-Data2.vhd"
$dataDisk2Name = $VMName+'-data2Disk'
$vm = Add-AzureRmVMDataDisk -VM $vm -Name $dataDisk2Name -Caching None -CreateOption Empty -DiskSizeInGB 512 -VhdUri $dataDisk2VhdUri -Lun 2

# Create Virtual Machine
Write-Output "Creating the VM" | timestamp
$NewVM = New-AzureRmVM -ResourceGroupName $RGName -Location $Location -VM $vm 
Write-Output "VM creation complete" | timestamp

#Now make a DC by running the first boot script
$ScriptBlobAccount = "<storage account name for assets>"
$ScriptBlobKey = "<storage key>"
$ScriptBlobURL = "https://<storage account name for assets>.blob.core.windows.net/scripts/"
 
$ScriptName = "FirstBoot.ps1"
$ExtensionName = 'FirstBootScript'
$ExtensionType = 'CustomScriptExtension' 
$Publisher = 'Microsoft.Compute'  
$Version = '1.8'
$timestamp = (Get-Date).Ticks
 
$ScriptLocation = $ScriptBlobURL + $ScriptName
$ScriptExe = ".\$ScriptName"
 
$PrivateConfiguration = @{"storageAccountName" = "$ScriptBlobAccount";"storageAccountKey" = "$ScriptBlobKey"} 
$PublicConfiguration = @{"fileUris" = [Object[]]"$ScriptLocation";"timestamp" = "$timestamp";"commandToExecute" = "powershell.exe -ExecutionPolicy Unrestricted -Command $ScriptExe"}
 
Write-Output "Injecting First Boot PowerShell" | timestamp
Set-AzureRmVMExtension -ResourceGroupName $RGName -VMName $VMName -Location $Location `
 -Name $ExtensionName -Publisher $Publisher -ExtensionType $ExtensionType -TypeHandlerVersion $Version `
 -Settings $PublicConfiguration -ProtectedSettings $PrivateConfiguration
 
((Get-AzureRmVM -Name $VMName -ResourceGroupName $RGName -Status).Extensions | Where-Object {$_.Name -eq $ExtensionName}).Substatuses

Write-Output "Waiting 5 minutes for reboot to complete" | timestamp
Start-Sleep -Seconds 300 #Wait 5 minutes

#Have to remove the previous before creating a new one
Remove-AzureRmVMExtension -ResourceGroupName $RGName -VMName $VMName -Name FirstBootScript -Force

#Now run the second boot script to install SQL and SharePoint
$ScriptName = "SecondBoot.ps1"
$ExtensionName = 'SecondBootScript'
$timestamp = (Get-Date).Ticks
 
$ScriptLocation = $ScriptBlobURL + $ScriptName
$ScriptExe = ".\$ScriptName"
 
$PrivateConfiguration = @{"storageAccountName" = "$ScriptBlobAccount";"storageAccountKey" = "$ScriptBlobKey"} 
$PublicConfiguration = @{"fileUris" = [Object[]]"$ScriptLocation";"timestamp" = "$timestamp";"commandToExecute" = "powershell.exe -ExecutionPolicy Unrestricted -Command $ScriptExe"}
 
Write-Output "Injecting Second Boot PowerShell" | timestamp
Set-AzureRmVMExtension -ResourceGroupName $RGName -VMName $VMName -Location $Location `
 -Name $ExtensionName -Publisher $Publisher -ExtensionType $ExtensionType -TypeHandlerVersion $Version `
 -Settings $PublicConfiguration -ProtectedSettings $PrivateConfiguration
 
((Get-AzureRmVM -Name $VMName -ResourceGroupName $RGName -Status).Extensions | Where-Object {$_.Name -eq $ExtensionName}).Substatuses

Remove-AzureRmVMExtension -ResourceGroupName $RGName -VMName $VMName -Name SecondBootScript -Force

Write-Output "Installation complete" | timestamp