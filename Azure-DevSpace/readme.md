## Azure Dev-Spaces  (AKS Cluster)

- https://docs.microsoft.com/en-us/azure/dev-spaces/



### Create Dev-spaces (Azure Kubernetes Service)

- https://docs.microsoft.com/en-us/azure/dev-spaces/how-to/create-cluster-cloud-shell

```
az group create --name azureDevSpaces --location westeurope

az aks create -g azureDevSpaces -n MyAKS --location westeurope --generate-ssh-keys

az aks use-dev-spaces -g azureDevSpaces -n MyAKS --space dev --yes

```


### quickstart AKS devepoment from azure-cli

https://docs.microsoft.com/en-us/azure/dev-spaces/quickstart-cli


```
$resourceGroup='MyKubernetes'
$aksName='MyAKS'

az group create --name $resourceGroup --location westeurope
az aks create -g $resourceGroup -n $aksName --location westeurope --disable-rbac --generate-ssh-keys

az aks use-dev-spaces -g $resourceGroup -n $aksName
git clone https://github.com/Azure/dev-spaces
cd dev-spaces/samples/nodejs/getting-started/webfrontend

azds prep --public

azds up
code .
azds up

```







