using System;
using Microsoft.ServiceBus.Messaging;
using Newtonsoft.Json;

namespace ServiceBusQueueSender
{
    public class CreateGreetingRequest
    {
        public string Number;
        public string FirstName;
    }

    class Program
    {
        static void Main(string[] args)
        {
            var connectionString = "Endpoint=sb://triggersqsbus.servicebus.windows.net/;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=Ylv8tnm9c5Nzupc00ALg4zFVFKVZ8UlAtHljkFQv/4A=";                                    
            var queueName = "greetingcreationrequests";

            var client = QueueClient.CreateFromConnectionString(connectionString, queueName);

            for (int i = 0; i < 100; i++)
            {
                var request = new CreateGreetingRequest
                {
                    Number = i.ToString(),
                    FirstName = $"Gentry{i}"
                };

                Console.WriteLine($"Sending {request.FirstName}");
                var message = new BrokeredMessage(JsonConvert.SerializeObject(request));

                client.Send(message);
            }

            client.Close();
        }
    }
}
