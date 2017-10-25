

. ./login.ps1

$resourceGroup = "automation"
$vmName = "win-web"
$vm2Name = "ub-proxy"


Import-Module AzureRM

#Windows Server - after sysprep

$VMStatus =  Get-AzureRMVM -ResourceGroupName $resourceGroup -Name $vmName -Status
$VMStatus 

Stop-AzureRmVM -ResourceGroupName $resourceGroup -Name $vmName -Force
Set-AzureRmVM -ResourceGroupName $resourceGroup -Name $vmName -Generalized
Save-AzureRmVMImage -ResourceGroupName $resourceGroup -Name $vmName -DestinationContainerName "vm-images" -VHDNamePrefix "win-web-app" -Path "win-web-app.json"

# Look at the generated file win-web-app.json for image.uri 
# copy the uri to "m2-create-windows-web-app-vm.ps1"




#Linux Server - after waagent
Stop-AzureRmVM -ResourceGroupName $resourceGroup -Name $vm2Name -Force
Set-AzureRmVM -ResourceGroupName $resourceGroup -Name $vm2Name -Generalized
Save-AzureRmVMImage -ResourceGroupName $resourceGroup -Name $vm2Name -DestinationContainerName "vm-images" -VHDNamePrefix "ub-proxy" -Path "ub-proxy.json"


# Look at the generated file ub-proxy.json for image.uri 
# copy the uri to "m2-create-linux-proxy-vm.ps1"

Remove-AzureRmVM -ResourceGroupName $resourceGroup -Name $vmName -Force
Remove-AzureRmVM -ResourceGroupName $resourceGroup -Name $vm2Name -Force

