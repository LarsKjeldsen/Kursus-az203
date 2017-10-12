﻿break
# #############################################################################
# Manage App Service Plans
# NAME: PS-70532-WEBAPPS-MOD02.ps1
# AUTHOR:  Tim Warner
# EMAIL: timothy-warner@pluralsight.com
# #############################################################################
 
# Press CTRL+M to expand/collapse regions

#region Log into Azure
# connect to subscription (ARM)
Login-AzureRmAccount
Select-AzureRmSubscription -SubscriptionName '150dollar'
Set-AzureRmCurrentStorageAccount -ResourceGroupName 'DefaultARMResourceGroup' -StorageAccountName 'defaultarmstorageaccount' 
Get-AzureRmSubscription

# certificate-based authentication
Get-AzurePublishSettingsFile 
Import-AzurePublishSettingsFile -PublishSettingsFile 'path'

# connect to subscription (ASM)
Add-AzureAccount
Select-AzureSubscription -SubscriptionName '150dollar' -Default
Set-AzureSubscription -SubscriptionName '150dollar' -CurrentStorageAccountName '532asmstorage'
#endregion

#region App Service Plan metadata

Get-Command -Module Azure -noun *hostingplan*

Get-Command -Noun *serviceplan*

New-AzureRmAppServicePlan -ResourceGroupName 'DefaultARMResourceGroup' `
                          -Name 'TempServicePlan' `
                          -Location "South Central US"  `
                          -Tier Standard 

Get-AzureRmAppServicePlan -Name 'TempServicePlan'

Remove-AzureRmAppServicePlan -Name 'TempServicePlan' -ResourceGroupName 'DefaultARMResourceGroup' -Force

#endregion

#region A bit o' Azure CLI

azure login

azure account list

azure account set 

azure config mode arm

azure config mode asm

azure site/webapp --help

azure site list

azure resource list 'resourcegroupname'

azure resource show 'resourcegroupname' microsoft.compute

azure logout -u tsw2002@comcast.net

#endregion
