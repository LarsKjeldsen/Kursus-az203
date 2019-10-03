## Send an event to your Event Grid Topic

param(
  $message = "der-er-sket-noget",
  $subject = "superusers/kursus/hver-gang-der-sker-noget-et-eller-andet-sted-kan-vi-fange-det" 
)

# Resource Group Name
$RG="az-203"
# The name of Event Grid Topic
$topicname="superusers-kursus"

# Query the endpoint from eventgrid topic
$URL=$(az eventgrid topic show --name $topicname -g $RG --query "endpoint" --output tsv)

# Query the key1 --> used by the owner
$primaryKey=$(az eventgrid topic key list --name $topicname -g $RG --query "key1" --output tsv)

# Query the key2 --> will be rotated --> can be shared to clients
$sharedKey=$(az eventgrid topic key list --name $topicname -g $RG --query "key2" --output tsv)


# Build The Message to be sent to Event Grid
$eventID = Get-Random 99999
$eventDate = Get-Date -Format s
$htbody = @{
    id=$eventID
    eventType=$message
    subject=$subject    
    eventTime=$eventDate   
    data= @{
        x="xxxx"
        y="yyyy"
        z="zzzz"
    }
    dataVersion="1.0"
}

# Convert from object to JSON
$body = "["+(ConvertTo-Json $htbody)+"]"


# USE HTTP POST with a valid Token and Body as JSON
Invoke-WebRequest -Uri $URL -Method POST -Body $body -Headers @{"aeg-sas-key" = $primaryKey}

