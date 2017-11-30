#load "..\sharedcode\CreateGreetingRequest.csx" 
#load "..\sharedcode\GreetingRequest.csx" 

#r "Newtonsoft.Json"

using System;
using Newtonsoft.Json;

public static void Run(CreateGreetingRequest myQueueItem, 
                       TraceWriter log,
                       out string outputBlob,
                       DateTimeOffset insertionTime,
                       string id)
{
    log.Info($"Queue Trigger {myQueueItem}");
    log.Info($"Insertion Time {insertionTime}");
    log.Info($"Id {id}");

    var greetingRequest = new GreetingRequest
    {   
        Number = myQueueItem.Number,
        Message = GenerateGreeting(myQueueItem.FirstName)
    };

    outputBlob = JsonConvert.SerializeObject(greetingRequest);
}

private static string GenerateGreeting(string firstName)
{
    string greeting;

    int hourOfDay = DateTime.Now.Hour;

    if (hourOfDay > 18) 
        greeting = "Good evening";
    else if (hourOfDay > 12)
        greeting = "Good afternoon";
    else
        greeting = "Good morning";

    return $"{greeting} {firstName}";
}