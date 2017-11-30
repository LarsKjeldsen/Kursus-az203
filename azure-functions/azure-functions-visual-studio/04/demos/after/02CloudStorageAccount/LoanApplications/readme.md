
# Flow 

```

1) HTTP POST listener on address http://localhost:7071/api/MakeApplication 

2) When request body contains (name='Nadine' age='16' )

3) MakeApplications runs > sends data to Queue Storage 

4) Using Azure Storage AccountName=ae76a2db28ee54684b66f483 


```



## Test 

```
 http post  http://localhost:7071/api/MakeApplication name='Jalal' age='40'

```

