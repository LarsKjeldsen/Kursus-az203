#r "Microsoft.WindowsAzure.Storage"
#r "System.Configuration"

using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure.Storage;
using System.Configuration;


using System;

public static void Run(TimerInfo myTimer, TraceWriter log)
{
    log.Info($"C# Timer trigger function executed at: {DateTime.Now}");  

    log.Info($"Timer schedule: {myTimer.Schedule}");
    log.Info($"Timer last execution: {myTimer.ScheduleStatus.Last}");
    log.Info($"Timer next execution: {myTimer.ScheduleStatus.Next}");  

    string connectionString = ConfigurationManager.AppSettings["triggersqsstorage_STORAGE"];

    CloudStorageAccount storageAccount = CloudStorageAccount.Parse(connectionString);
    CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();
    CloudBlobContainer container = blobClient.GetContainerReference("sms-receipts");

    DateTime oldestAllowedTime = DateTime.Now.Subtract(TimeSpan.FromMinutes(1));

    log.Info($"Checking for old sms receipts");
    foreach (CloudBlockBlob blob in container.ListBlobs().OfType<CloudBlockBlob>())
    {        
        var isTooOld = blob.Properties.LastModified < oldestAllowedTime;

        if (isTooOld)
        {
            log.Info($"Deleting blob {blob.Name}");
            blob.Delete();
        }
    }
}