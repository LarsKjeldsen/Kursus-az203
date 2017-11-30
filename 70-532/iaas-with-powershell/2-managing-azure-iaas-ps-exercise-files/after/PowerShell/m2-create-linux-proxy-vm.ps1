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
    $SubnetIndex
)

$ubImageUri = "https://ms20532.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-proxy-osDisk.1305530f-2b2b-40e7-a6b3-49fb89a62275.vhd"

$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
$vnet = Get-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName

$nicName = "$vmName-nic"

$pip = New-AzureRmPublicIpAddress -Name $nicName -ResourceGroupName $ResourceGroup -Location $Location -AllocationMethod Dynamic     

$nic = New-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName `
                                   -Location $Location -SubnetId $vnet.Subnets[$SubnetIndex].Id `
                                   -PublicIpAddressId $pip.Id


$vm = New-AzureRmVMConfig -VMName $VmName -VMSize "Basic_A1" 

$cred = Get-Credential -Message "Admin credentials"
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Linux  -ComputerName $VmName -Credential $cred 

$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id

$diskName = $VmName + "-os-disk"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"
$vm=Set-AzureRmVMOSDisk -VM $vm -Name $diskName -VhdUri $osDiskUri -CreateOption fromImage -SourceImageUri $ubImageUri -Linux

New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vm 