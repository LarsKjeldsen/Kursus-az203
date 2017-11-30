
# Flow 

```

1) HTTP POST listener on address http://localhost:7071/api/MakeApplication 

2) When request body contains (name='Nadine' age='16' )

3) MakeApplications runs > sends data to Queue Storage 

4) When Queue Storage receives data of type LoanApplication 

5) ScoreApplications runs > Read/fetch data from Queue Storage make a decision 

6) [Blob("accepted-applications/{rand-guid}")] out string acceptedApplication

7) [Blob("declined-applications/{rand-guid}")] out string declinedApplication



```



## Test ScoreApplication for Blob("accepted-applications/guid") 

```
 http post  http://localhost:7071/api/MakeApplication name='Jalal' age='40'

```



## Test ScoreApplication for Blob("declined-applications/guid") 

```
 http post  http://localhost:7071/api/MakeApplication name='Nadine' age='16'

```

