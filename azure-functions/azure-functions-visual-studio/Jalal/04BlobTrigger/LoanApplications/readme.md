
# Flow 

```

1) HTTP POST listener on address http://localhost:7071/api/MakeApplication 

2) When request body contains (name='Nadine' age='16' )

3) MakeApplications runs > sends data to Queue Storage 

4) When Queue Storage receives data of type LoanApplication 

5) ScoreApplications runs > Read/fetch data from Queue Storage make a decision 

6) [Blob("accepted-applications/{rand-guid}")] out string acceptedApplication

7) [Blob("declined-applications/{rand-guid}")] out string declinedApplication

8)  ProcessAcceptedApplications runs > read from Blob("accepted-applications/{rand-guid}")

	ProcessAcceptedApplications Blob trigger for
	 Name:Jalal
	 Age: 40


 9)  ProcessDeclinedApplications runs > read from Blob("declined-applications/{rand-guid}")

	ProcessDeclinedApplications Blob trigger for
	 Name:Nadine
	 Age: 16


```



## Test ScoreApplication for Blob("accepted-applications/guid") 

```
 http post  http://localhost:7071/api/MakeApplication name='Jalal' age='40'


```


## Test ScoreApplication for Blob("declined-applications/guid") 

```
 http post  http://localhost:7071/api/MakeApplication name='Nadine' age='16'

```



## Deployment to Azure 

```
http://loanapplicationsuperusers.azurewebsites.net

http post http://loanapplicationsuperusers.azurewebsites.net/MakeApplication?code=Q+Co9pijZo93iTe4wtw3suVb1/bdkplBvU40RXkGMOPLHCK9OWBo4yppP6gp9VVCZWDO89o2KpAMXrXU3Ber9w== Name=Jalal  Age=40 


```