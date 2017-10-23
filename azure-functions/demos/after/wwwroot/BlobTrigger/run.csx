#load "..\sharedcode\GreetingRequest.csx"
#load "..\sharedcode\SmsSentConfirmation.csx" 

#r "Microsoft.WindowsAzure.Storage"
#r "Newtonsoft.Json"

using Newtonsoft.Json;
using Microsoft.WindowsAzure.Storage.Blob;


public static void Run(CloudBlockBlob myBlob, 
                       string name, 
                       TraceWriter log,
                       Stream outputBlob)
{
    log.Info($"C# Blob trigger function Processed blob\n Name:{name}");

    log.Info("Metadata:");
    log.Info($"- Name: {myBlob.Name}");
    log.Info($"- StorageUri: {myBlob.StorageUri}");
    log.Info($"- Container: {myBlob.Container.Name}");

    GreetingRequest greetingRequest = DownloadGreetingRequest(myBlob);
    log.Info($"Downloaded: {greetingRequest}");


    string sendReceiptId = SendSms(greetingRequest);    

    var confirmation = new SmsSentConfirmation
    {
        ReceiptId = sendReceiptId,
        Number = greetingRequest.Number,
        Message = greetingRequest.Message
    };

    UploadSmsSentConfirmation(confirmation, outputBlob);
}

public static GreetingRequest DownloadGreetingRequest(CloudBlockBlob blob)
{
    GreetingRequest greetingRequest;

    using (var ms = new MemoryStream())
    {
        blob.DownloadToStream(ms);
        
        ms.Position = 0;
    
        using (var sr = new StreamReader(ms))
        {
            using (var jsonTextReader = new JsonTextReader(sr))
            {
                var serializer = new JsonSerializer();
                greetingRequest = serializer.Deserialize<GreetingRequest>(jsonTextReader);
            }
        }
    }

    return greetingRequest;
}

public static string SendSms(GreetingRequest request)
{
    // simulate sending sms and returning external receipt GUID
    return Guid.NewGuid().ToString();
}


public static void UploadSmsSentConfirmation(SmsSentConfirmation confirmation, Stream outputBlob)
{
    using (var writer = new StreamWriter(outputBlob))
    {
        using (var jsonWriter = new JsonTextWriter(writer))
        {
            JsonSerializer ser = new JsonSerializer();
            ser.Serialize(jsonWriter, confirmation);
            jsonWriter.Flush();
        }
    }
}