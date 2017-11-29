
## http is installed using https://github.com/jakubroztocil/httpie#installation

http post  http://localhost:7071/api/MakeApplication name='Jalal' age='40'

<# 

HTTP/1.1 200 OK
Content-Type: application/json; charset=utf-8
Date: Wed, 29 Nov 2017 11:40:20 GMT
Server: Microsoft-HTTPAPI/2.0
Transfer-Encoding: chunked

"Loan application submitted for Jalal with Age: 40 "

#>


## Hosting 

http://loadapplication01.azurewebsites.net/


## testing online 

http post https://loadapplication01.azurewebsites.net/api/MakeApplication?code=Fwld4qja1MRAdqFb6gwacWGaWZNR1UnRCPaCNuJMserBCeDuEud0Ag== name=Jalal  Age=44


