

# First login
Login-AzureRMAccount


# Start all your WebApps
Get-AzureRmWebApp | Start-AzureRmWebApp  


# Stop all your WebApps
Get-AzureRmWebApp | Stop-AzureRmWebApp  


# Restart all your WebApps
Get-AzureRmWebApp | Restart-AzureRmWebApp  



# Remove/Delete all your WebApps
Get-AzureRmWebApp | Remove-AzureRmWebApp  



