Import-Module AzureRM.Profile

##############################################################
# login 

Login-AzureRmAccount 

$MySubscription = "Visual Studio Ultimate med MSDN"

Select-AzureRmSubscription -Subscription $MySubscription

################################################################
