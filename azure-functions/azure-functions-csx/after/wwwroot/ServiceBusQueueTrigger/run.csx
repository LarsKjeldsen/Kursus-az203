#load "..\sharedcode\CreateGreetingRequest.csx"

#r "Newtonsoft.Json"

using System;
using Newtonsoft.Json;

public static void Run(string myQueueItem, TraceWriter log)
{
    CreateGreetingRequest request = JsonConvert.DeserializeObject<CreateGreetingRequest>(myQueueItem);

    log.Info($"Received: {request}");  
}