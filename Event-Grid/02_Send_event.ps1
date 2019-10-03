## Send an event to your custom topic

$RG="az-203"
$topicname="superusers-kursus"

$URL=$(az eventgrid topic show --name $topicname -g $RG --query "endpoint" --output tsv)
$primaryKey=$(az eventgrid topic key list --name $topicname -g $RG --query "key1" --output tsv)

$eventID = Get-Random 99999
$eventDate = Get-Date -Format s
$htbody = @{
    id= $eventID
    eventType="der-er-sket-noget"
    subject="superusers/kursus/hver-gang-der-sker-noget-et-eller-andet-sted-kan-vi-fange-det"
    eventTime= $eventDate   
    data= @{
        x="xxxx"
        y="yyyy"
    }
    dataVersion="1.0"
}

$body = "["+(ConvertTo-Json $htbody)+"]"

Invoke-WebRequest -Uri $URL -Method POST -Body $body -Headers @{"aeg-sas-key" = $primaryKey}