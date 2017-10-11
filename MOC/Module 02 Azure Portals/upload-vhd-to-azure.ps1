
<#

Først klargøre VM:

1) Connect using Remote desktop 

2) C:\Windows\System32\Sysprep\sysprep.exe 


#>

Login-AzureRMAccount 

Get-AzureRMStorageAccountKey -ResourceGroupName demos -name ncgdemos

$context = New-AzureStorageContext -StorageAccountName ncgdemos -StorageAccountKey "secret****"
$vhdUrl  = "https://ncgdemos.blob.core.windows.net/vhds/win10os.vhd"
$file    = "C:\Images\Win10os.vhd"

Add-AzureRMVhd -ResourceGroupName "demos" -Destination $vhdUrl -LocalFilePath $file 


<#
    wait ...
    
    see ./ps_create_vm_from_vhd.JPG

#>