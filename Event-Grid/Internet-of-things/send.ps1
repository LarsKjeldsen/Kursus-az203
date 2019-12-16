## Send an event to a WebHook

param(
  $message = "besked",
  $subject = "titel",
  $x = "xxx",
  $y = "yyy",
  $z = "zzz" 
)

# $url    = "https://superusers-kursus.westeurope-1.eventgrid.azure.net/api/events"
# $url    = get-azure-secret event-grid-url
# $secret = get-azure-secret event-grid-key

# [Environment]::SetEnvironmentVariable("event-grid-url", $url  , 'User')
# [Environment]::SetEnvironmentVariable("event-grid-key", $secret, 'User')


$WebHookAddress = [Environment]::GetEnvironmentVariable("event-grid-url", 'User')
$key =            [Environment]::GetEnvironmentVariable("event-grid-key", 'User')


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



