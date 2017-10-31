
## ref.: https://docs.microsoft.com/en-us/azure/virtual-machines/scripts/virtual-machines-windows-cli-sample-create-vm-quick-create?toc=%2fcli%2fazure%2ftoc.json



# Update for your admin password
$AdminPassword="***********"
$UserName     ="Jalal" 

# Create a resource group.
az group create --name Default-Web-NorthEurope --location northeurope

# Create a virtual machine. 
az vm create \
    --resource-group Default-Web-NorthEurope \
    --name Dev20532 \
    --image win2016datacenter \
    --admin-username $UserName \
    --admin-password $AdminPassword \
    --no-wait


