#########################################################################
# Event-Grid (FaaS) Setup and Registrations
#########################################################################


$RG="az-203"
$location="westeurope"


az group delete --name $RG --yes 
az group create --name $RG --location $location

## Enable Event Grid resource provider
az provider register --namespace Microsoft.EventGrid
az provider show --namespace Microsoft.EventGrid --query "registrationState"

$topicname="superusers-kursus"
az eventgrid topic create --name $topicname -l $location -g $RG





#########################################################################
# Storage Account to save the state and data 
#########################################################################
$storagename="superusers2019"
$queuename="kursusqueue"

az storage account create -n $storagename -g $RG -l $location --sku Standard_LRS
az storage queue create --name $queuename --account-name $storagename

$storageid=$(az storage account show --name $storagename --resource-group $RG --query id --output tsv)
$queueid="$storageid/queueservices/default/queues/$queuename"
$topicid=$(az eventgrid topic show --name $topicname -g $RG --query id --output tsv)

az eventgrid event-subscription create `
  --source-resource-id $topicid `
  --name "$topicname-queue" `
  --endpoint-type storagequeue `
  --endpoint $queueid `
  --expiration-date "2020-01-01"






#########################################################################
#  WebApp Monitor and logging
#########################################################################

$sitename="superusers-kursus-demo-event-grid-2019"

az group deployment create `
  --resource-group $RG `
  --template-uri "https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/master/azuredeploy.json" `
  --parameters siteName=$sitename hostingPlanName=viewerhost








#########################################################################
#  Subscribe to my custom topic
#########################################################################

$webhook="https://$sitename.azurewebsites.net/api/updates"

az eventgrid event-subscription create `
  -g $RG `
  --topic-name $topicname `
  --name webappMonitor `
  --endpoint $webhook




