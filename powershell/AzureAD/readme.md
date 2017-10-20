
## AzureAD Module 

```
sudo install-module AzureAD -force

Get-Command -module AzureAD 

```


## Create new Application for Azure AD from powershell 

```
New-AzureADApplication -DisplayName "My new application"  -IdentifierUris "http://mynewapp.contoso.com"
```