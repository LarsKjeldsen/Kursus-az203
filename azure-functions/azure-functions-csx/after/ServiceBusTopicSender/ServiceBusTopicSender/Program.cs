using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ServiceBus.Messaging;
using Newtonsoft.Json;

namespace ServiceBusTopicSender
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
            var topic = "greetingcreationrequeststopic";

            var topicClient = TopicClient.CreateFromConnectionString(connectionString, topic);            

            for (int i = 0; i < 100; i++)
            {
                var request = new CreateGreetingRequest
                {
                    Number = i.ToString(),
                    FirstName = $"Amrit{i}"
                };

                Console.WriteLine($"Sending {request.FirstName}");
                var message = new BrokeredMessage(JsonConvert.SerializeObject(request));

                topicClient.Send(message);
            }

            topicClient.Close();
        }
    }
}
