#load "..\sharedcode\CreateGreetingRequest.csx"

#r "Newtonsoft.Json"

using System.Net;
using Newtonsoft.Json;

public static async Task<HttpResponseMessage> Run(HttpRequestMessage req, 
                                                  TraceWriter log,
                                                  IAsyncCollector<CreateGreetingRequest> outputQueue)
{
    string jsonContent = await req.Content.ReadAsStringAsync();
    
    CreateGreetingRequest data = JsonConvert.DeserializeObject<CreateGreetingRequest>(jsonContent);
        
    await outputQueue.AddAsync(data);
    
    log.Info($"Added {data} to queue");

    return req.CreateResponse(HttpStatusCode.OK, "Request added to queue");
}