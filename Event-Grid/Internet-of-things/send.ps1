## Send an event to a WebHook

param(
  $WebHookAddress = "https://superusers-kursus.westeurope-1.eventgrid.azure.net/api/events",
  $token = "secret",
  $message = "besked",
  $subject = "titel",
  $x = "xxx",
  $y = "yyy",
  $z = "zzz" 
)

# Build The Message to be sent to Event Grid
$eventID = Get-Random 99999
$eventDate = Get-Date -Format s
$htbody = @{
    id=$eventID
    eventType=$message
    subject=$subject    
    eventTime=$eventDate   
    data= @{
        x=$x
        y=$y
        z=$z
    }
    dataVersion="1.0"
}

# Convert from object to JSON
$body = "["+(ConvertTo-Json $htbody)+"]"

# USE HTTP POST with a valid Token and Body as JSON
Invoke-WebRequest -Uri $WebHookAddress -Method POST -Body $body -Headers @{"aeg-sas-token" = $token}
