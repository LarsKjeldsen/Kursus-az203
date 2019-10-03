## Send an event to a WebHook

param(
  $WebHookAddress = "https://superusers-kursus.westeurope-1.eventgrid.azure.net/api/events",
  $key = "secret",
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


# https://docs.microsoft.com/en-us/azure/event-grid/security-authentication#custom-topic-publishing
# USE HTTP POST with a valid key and Body as JSON
Invoke-WebRequest -Uri $WebHookAddress -Method POST -Body $body -Headers @{"aeg-sas-key" = $key}
