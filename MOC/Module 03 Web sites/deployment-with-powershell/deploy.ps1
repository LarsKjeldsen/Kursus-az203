<#
 Deploy Web Apps from my private gitlab repo
 
 
AzureCloud set fra en udvikler OOP, en Object Tree. 
For at oprette/administrerer WebSites som har typen AppService, skal man igennem Root-access først. 

Root-level er API Access 
https://docs.microsoft.com/en-us/rest/api/

GET https://management.azure.com/subscriptions/{subscriptionId}/resources?api-version=2017-05-10

http GET https://management.azure.com/subscriptions/6ef2cbd4-1b87-4409-ab0e-403ffe9024b3/resources?api-version=2017-05-10


Azure API version1 ASM > 
Azure API version2 ARM > 
                        Subscription > 
                            ResourceGroup >
                                App Service plan>     
                                        App Service> 

#>



# Authenticate to ARM
Login-AzureRmAccount


#######################################################################
## Readonly data
# Get-AzureRmSubscription
$Subscription_Azure_pass    = "Azure-pass-MS-532"
$Subscription_Azure_pass_Id = "a22beb2b-b84a-4811-a34f-8eda7bdaaae5"

# Set the Subscription for deployment 
Select-AzureRmSubscription  -SubscriptionName   $Subscription_Azure_pass
Set-AzureRmContext          -SubscriptionId     $Subscription_Azure_pass_Id

#######################################################################



#######################################################################
# New Resources to create for first time (run once)

$ResourceGroupName = "ARMResourceGroup" 
$ARMServicePlan    = "ARMServicePlan"
$Location          = "South Central US"
$ResourceName      = "ms20532-lab03-version-x"

# Create resource group (only run once)
# New-AzureRmResourceGroup -Name ARMResourceGroup -Location $Location -Force

# Create app service plan (only run once)
# New-AzureRmAppServicePlan -ResourceGroupName $ResourceGroupName -Name $ARMServicePlan -Location $Location -Tier "Standard"  -NumberofWorkers 1 -WorkerSize "Small"

# Migrate a website to the ARMServicePlan
#$plan = @{'serverfarm' = $ARMServicePlan}
#Set-AzureRmResource -ResourceName $ResourceName -ResourceGroupName $ResourceGroupName -ResourceType 'Microsoft.Web/sites' -ApiVersion '2014-04-01' -Plan $plan
# There used to be Set-AzureResource and Get-AzureResource

# Enable Always On for an API app 
# Set-AzureRmResource -ResourceName $ResourceName  -ResourceGroupName $ResourceGroupName -ResourceType 'Microsoft.Web/sites' -ApiVersion '2015-08-01' -Properties @{"siteConfig" = @{"AlwaysOn" = $false}} -force 

#######################################################################




#######################################################################
<#
    Deploy as many times as needed 
    psedit '.\azuredeploy.json'
    psedit '.\azuredeploy.parameters.json'
#>


New-AzureRmResourceGroupDeployment -name "powershellDeployment" `
-ResourceGroupName $ResourceGroupName `
-TemplateFile '.\azuredeploy.json' `
-TemplateParameterFile '.\azuredeploy.parameters.json'

#######################################################################

