<#
    - Setup Azure App Service from remote git repository (manual-integration)
    - Setup AzureSQL Server, Database and Firewall
    - Configure AppService with connectionString
    - Migrate Azure Database from Entity Framework model

    run "az login" before anything
#>

$resourceGroup  = "kursus-az203"
$location       = "westeurope"
$appName        = "kursus-webapp-2020"

# create a resource group
az group create -n $resourceGroup -l $location

# create the app service plan
$planName="$appName-hardware"
az appservice plan create -n $planName -g $resourceGroup --sku B1

# create the webapp
az webapp create -n $appName -g $resourceGroup --plan $planName
$gitrepo="https://superusers-kursus@dev.azure.com/superusers-kursus/Webapp-snippets/_git/Webapp-snippets"
az webapp deployment source config -n $appName -g $resourceGroup --repo-url $gitrepo --branch master --manual-integration


# (optional) sync WebApp from source/git latest commit
# az webapp deployment source sync -n $appName -g $resourceGroup


<#############################################################################################
ProTip: Use Azure key-vault to get secrets for SQLSERVER and Build ConnectionString
    
sourcecode for get-azure-secret: 
https://dev.azure.com/superusers-kursus/_git/windowspowershell?path=%2Fazure%2Fsecrets.ps1
###############################################################################################>

$sqlServerName=         get-azure-secret -secretName kursus-sqlserver-servername
$databaseName =         get-azure-secret -secretName kursus-sqlserver-databasename
$sqlServerUsername =    get-azure-secret -secretName kursus-sqlserver-loginname
$sqlServerPassword =    get-azure-secret -secretName kursus-sqlserver-loginpassword

# create the SQL server
az sql server create -n $sqlServerName -g $resourceGroup -l $location -u $sqlServerUsername -p $sqlServerPassword

# create the database
az sql db create -g $resourceGroup -s $sqlServerName -n $databaseName --service-objective Basic


# Connect SQL server to web app

# allow IP address or All to access SQL server Firewall
$ipAddress = "0.0.0.0"
az sql server firewall-rule create -g $resourceGroup -s $sqlServerName -n AllowWebApp1 --start-ip-address $ipAddress --end-ip-address $ipAddress


# construct the connection string
$connectionString="Server=tcp:$sqlServerName.database.windows.net;Initial Catalog=$databaseName;User ID=$sqlServerUsername@$sqlServerName;Password=$sqlServerPassword;Trusted_Connection=False;Encrypt=True;"


# provide add the connection string to the web app
az webapp config connection-string set -n $appName -g $resourceGroup -t SQLAzure --settings "SnippetsContext=$connectionString"

# To migrate/setup the database model to SQLServer
# pip install httpie
$site = $( az webapp show -n $appName -g $resourceGroup --query "defaultHostName" -o tsv)
http get "https://$site/migrate"