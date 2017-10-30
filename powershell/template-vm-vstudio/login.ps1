Import-Module AzureRM.Profile

##############################################################
# login 

Login-AzureRmAccount 

$MySubscription = "Azure-pass-MS-532"

Select-AzureRmSubscription -Subscription $MySubscription

################################################################
