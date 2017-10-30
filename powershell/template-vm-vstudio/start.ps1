 <# 
Name     : Azure-pass-MS-532
Id       : a22beb2b-b84a-4811-a34f-8eda7bdaaae5

#>

## I skal lave om på  subscriptionId
$subscriptionId         = "*****************"


## resten af navngivning er op til dig

$resourceGroupName      = "kursus-ms532-gruppe"
$resourceGroupLocation  = "north europe" 
$deploymentName         = "kursus-deployment"

 . ./deploy.ps1 -parametersFilePath    parameters.json `
                -subscriptionId        $subscriptionId `
                -resourceGroupName     $resourceGroupName `
                -resourceGroupLocation $resourceGroupLocation `
                -deploymentName        $deploymentName