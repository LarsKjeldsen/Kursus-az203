
## Storage queues and Service Bus queues - compared and contrasted

Reference Links: http://go.microsoft.com/fwlink/?LinkID=510217



## Storage queue vs. Service Bus


```
Storage queue is for simple solution --> simple HTTP REST endpoints

Service Bus is for advanced solution --> cross-platform hybrid Apps

By gaining a deeper understanding of the two technologies, you will be able to make a more informed decision on which queue technology to use, and when. The decision on when to use Storage queues or Service Bus queues clearly depends on a number of factors. These factors may depend heavily on the individual needs of your application and its architecture. If your application already uses the core capabilities of Microsoft Azure, you may prefer to choose Storage queues, especially if you require basic communication and messaging between services or need queues that can be larger than 80 GB in size.
Because Service Bus queues provide a number of advanced features, such as sessions, transactions, duplicate detection, automatic dead-lettering, and durable publish/subscribe capabilities, they may be a preferred choice if you are building a hybrid application or if your application otherwise requires these features.

```



## Question

Which queuing mechanism is better suited for storing large messages?

```
The Queue service in Azure Storage can store over 5GB worth of messages in a queue.
```

## Question

If you have an application that cannot afford to lose any messages, should you use the PeekLock or ReceiveAndDelete mode in your consuming client? How do you check to see if the message is a duplicate?

```
PeekLock allows you to retry messages that you might have failed to process. The MessageId of the message will be consistent across tries and allows you to determine if you are processing a duplicate message.
```

## Question

You have a weather app and you are using Notification Hubs for messaging. You would like to let people within a specific area code receive an emergency alert about a hurricane. How should you architect your application to support this scenario?

```
First, you should start by designing the templates that specify how the notification should appear for the emergency alert message on each platform. Then the client applications can register by using that template and some location data (such as an area code) included in their tag(s). When an emergency alert needs to be sent out, you can use target-specific area codes in your tags and use the emergency message template to send a single message to notify all the targeted clients.

```

