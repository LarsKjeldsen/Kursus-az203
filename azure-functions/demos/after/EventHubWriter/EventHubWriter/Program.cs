using System;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Azure.EventHubs;
using Newtonsoft.Json;

namespace EventHubWriter
{
    class CreateGreetingRequest
    {
        public string Number;
        public string FirstName;
    }
    class Program
    {
        private static EventHubClient _eventHubClient;       
        private const string ConnectionString = "Endpoint=sb://triggersqs.servicebus.windows.net/;EntityPath=greetingcreationrequests;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=HlB6s023Wr5fyPtYhJxB6R2y+f6o79LWbsuQ5049EWc=";

        static void Main(string[] args)
        {
            CreateEventHubClient();

            SendMessages().GetAwaiter().GetResult();
        }
        static async Task SendMessages()
        {        
            for (int i = 0; i < 100; i++)
            {
                var message = new CreateGreetingRequest
                {
                    Number = i.ToString(),
                    FirstName = $"Sarah{i}"
                };

                Console.WriteLine($"Sending {message.FirstName}");
                await _eventHubClient.SendAsync(new EventData(Encoding.UTF8.GetBytes(JsonConvert.SerializeObject(message))));
            }

            await _eventHubClient.CloseAsync();
        }

        private static void CreateEventHubClient()
        {
            var connectionStringBuilder = new EventHubsConnectionStringBuilder(ConnectionString);

            _eventHubClient = EventHubClient.CreateFromConnectionString(connectionStringBuilder.ToString());
        }
    }
}
