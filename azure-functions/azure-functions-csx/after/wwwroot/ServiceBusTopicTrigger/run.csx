#load "..\sharedcode\CreateGreetingRequest.csx"

#r "Microsoft.ServiceBus"
#r "Newtonsoft.Json"

using System;
using Microsoft.ServiceBus.Messaging;
using Newtonsoft.Json;

public static void Run(BrokeredMessage mySbMsg, TraceWriter log)
{
    log.Info($"Brokered Message ID {mySbMsg.MessageId}");
    log.Info($"Brokered Message Enqueued Time Utc {mySbMsg.EnqueuedTimeUtc}");
    log.Info($"Brokered Message sequence number {mySbMsg.SequenceNumber}");

    string message = mySbMsg.GetBody<string>();

    CreateGreetingRequest request = JsonConvert.DeserializeObject<CreateGreetingRequest>(message);

    log.Info($"Received: {request}");
}