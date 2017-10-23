#load "..\sharedcode\CreateGreetingRequest.csx"

using System;

public static void Run(CreateGreetingRequest input, 
                       TraceWriter log,
                       out CreateGreetingRequest outputQueueItem)
{
    log.Info($"C# manually triggered function called with input: {input}");

    outputQueueItem = input;
}