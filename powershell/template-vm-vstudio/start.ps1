 <# 

Powershell environment: 
    Set-executionpolicy unrestricrted  -force
    Set-executionpolicy remotesigned   -force

Login-AzureRmAccount  er ikke tilgængeligt

download og installere Azure-ps 

iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop install azure-ps

 
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