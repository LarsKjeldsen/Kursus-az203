## Send an event to a WebHook

param(
  $message = "besked",
  $subject = "titel",
  $x = "xxx",
  $y = "yyy",
  $z = "zzz" 
)

$WebHookAddress = "https://superusers-kursus.westeurope-1.eventgrid.azure.net/api/events"

# [Environment]::SetEnvironmentVariable("event-grid-key", "XXXXXXXXXXXXXXXXXX", 'User')
$key =  [Environment]::GetEnvironmentVariable("event-grid-key", 'User')


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

Invoke-WebRequest -Uri $WebHookAddress -Method POST -Body $body -Headers @{"aeg-sas-key" = $key}


# USE HTTP POST with a valid key and Body as JSON
# http post $WebHookAddress --headers "aeg-sas-key:$key" $body


