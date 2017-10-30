 
 # . ./deploy.ps1 -TemplateParameterFile "env-development.json"
 # . ./deploy.ps1 -TemplateParameterFile "env-production.json"

 <# 

for at finde subscriptionID: 



Name     : Azure-pass-MS-532
Id       : a22beb2b-b84a-4811-a34f-8eda7bdaaae5

 #>



## I skal lave om på  subscriptionId
$subscriptionId         = "**************a22beb2b-b84a-4811-a34f-8eda7bdaaae5"

$resourceGroupName      = "kursus-ms532-gruppe"
$resourceGroupLocation  = "north europe" 
$deploymentName         = "kursus-deployment"

 . ./deploy.ps1 -parametersFilePath    parameters.json `
                -subscriptionId        $subscriptionId `
                -resourceGroupName     $resourceGroupName `
                -resourceGroupLocation $resourceGroupLocation `
                -deploymentName        $deploymentName