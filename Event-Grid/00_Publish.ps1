<#
    Azure Event Grid custom events
#>


$RG="az-203"

az group create --name $RG --location westeurope

## Enable Event Grid resource provider
az provider register --namespace Microsoft.EventGrid

az provider show --namespace Microsoft.EventGrid --query "registrationState"

$topicname="superusers-kursus"

az eventgrid topic create --name $topicname -l westeurope -g $RG


## Create a message endpoint

$sitename="superusers-kursus-demo-event-grid-2019"

az group deployment create `
  --resource-group $RG `
  --template-uri "https://raw.githubusercontent.com/Azure-Samples/azure-event-grid-viewer/master/azuredeploy.json" `
  --parameters siteName=$sitename hostingPlanName=viewerhost







