Param
(
    [Parameter(Mandatory=$true)]
    [String] 
    $ResourceGroupName,    
    [Parameter(Mandatory=$true)]
    [String] 
    $Location,
    [Parameter(Mandatory=$true)]
    [String]
    $StorageAccountName,    
    [Parameter(Mandatory=$true)]
    [String] 
    $VmName,    
    [Parameter(Mandatory=$true)]
    [String] 
    $VnetName,    
    [Parameter(Mandatory=$true)]
    [Int] 
    $SubnetIndex,  
    [Parameter(Mandatory=$true)]
    [String]
    $AvailabilitySetId,
    [Parameter(Mandatory=$true)]
    [String] 
    $LoadBalancerName
)

$winImageUri = "https://ms20532.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/win-web-app-osDisk.648afa2a-bd96-4037-8c46-ad6f91919925.vhd"

$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroup -Name $StorageAccountName
$vnet = Get-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroup 

$nicName = "$VmName-nic"

$lb = Get-AzureRmLoadBalancer -ResourceGroupName $ResourceGroupName -Name $LoadBalancerName

$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroup `
                                   -Location $Location -SubnetId $vnet.Subnets[$SubnetIndex].Id `
                                   -LoadBalancerBackendAddressPool $lb.BackendAddressPools[0]

$vm = New-AzureRmVMConfig -VMName $VmName -VMSize "Standard_A1" -AvailabilitySetId $AvailabilitySetId

$cred = Get-Credential -Message "Admin credentials"
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $VmName -Credential $cred `
                                 -ProvisionVMAgent -EnableAutoUpdate
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$diskName = $VmName + "-os-disk"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage -SourceImageUri $winImageUri -Windows

New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vm
