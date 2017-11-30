
# Flow 

```

1) HTTP POST listener on address http://localhost:7071/api/MakeApplication 

2) When request body contains (name='' age='' )

3) MakeApplications runs > sends data to Queue Storage 

4) Using Azure Storage AccountName=ae76a2db28ee54684b66f483 


```


## local.settings.json (using local Storage emulator)

```
{
    "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "AzureWebJobsDashboard": ""
  }
}

```


## Test

```
 http post  http://localhost:7071/api/MakeApplication name='Jalal' age='40'

```

