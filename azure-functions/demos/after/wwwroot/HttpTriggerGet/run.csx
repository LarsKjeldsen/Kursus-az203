#load "..\sharedcode\SmsSentConfirmation.csx" 

#r "Microsoft.WindowsAzure.Storage"
#r "System.Configuration"
#r "Newtonsoft.Json"

using System;
using System.Net;
using Microsoft.Azure;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage;
using System.Configuration;
using Newtonsoft.Json;

public static async Task<HttpResponseMessage> Run(HttpRequestMessage req, TraceWriter log, string name)
{
    log.Info("C# HTTP trigger function processed a request.");

    // parse query parameter
    // string name = req.GetQueryNameValuePairs()
    //     .FirstOrDefault(q => string.Compare(q.Key, "name", true) == 0)
    //     .Value;

    if (name == null)
    {
        return req.CreateResponse(HttpStatusCode.NotFound, "Please supply an sms receipt blob name query string parameter");
    }

    log.Info($"Blob name to load: {name}");

    SmsSentConfirmation confirmation = await DownloadSmsSentConfirmation(name);

    if (confirmation == null)
    {
        return req.CreateResponse(HttpStatusCode.NotFound, $"A blob called {name} was not found");
    }

    log.Info($"Downloaded: {confirmation}");

    return req.CreateResponse(HttpStatusCode.OK, confirmation);
}

public static async Task<SmsSentConfirmation> DownloadSmsSentConfirmation(string name)
{
    string connectionString = ConfigurationManager.AppSettings["triggersqsstorage_STORAGE"];
    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference("sms-receipts");

    CloudBlockBlob smsReceiptBlob = container.GetBlockBlobReference(name);

    if (! await smsReceiptBlob.ExistsAsync())
    {
        return null;
    }

    SmsSentConfirmation confirmation;

    using (var ms = new MemoryStream())
    {
        smsReceiptBlob.DownloadToStream(ms);        
        ms.Position = 0;
    
        using (var sr = new StreamReader(ms))
        {
            using (var jsonTextReader = new JsonTextReader(sr))
            {
                var serializer = new JsonSerializer();
                confirmation = serializer.Deserialize<SmsSentConfirmation>(jsonTextReader);
            }
        }
    }

    return confirmation;
}