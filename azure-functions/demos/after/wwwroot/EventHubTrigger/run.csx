#load "..\sharedcode\CreateGreetingRequest.csx"

using System;

public static void Run(CreateGreetingRequest myEventHubMessage, TraceWriter log)
{
    log.Info($"Received: {myEventHubMessage}");
}