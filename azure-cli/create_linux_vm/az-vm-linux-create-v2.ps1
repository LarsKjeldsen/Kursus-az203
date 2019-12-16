## How to create function in PowerShell
function create-vm-linux{
    param(
        $rgName="vm2020",
        $VMName="dev2020",
        $secret
    )
    az group create --location westus --name $rgName
    az vm create --resource-group $rgName --name $VMName --image Debian --admin-username sysadmin --admin-password $secret --tags "env=training"
}

## get secret from Azure key-vault 
create-vm-linux  -secret (get-azure-secret sysadmin)
