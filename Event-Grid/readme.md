## Event-Grid (reactive programming)

Event Grid is really about eventing (when an event happen).

Event Grid is for reactive programming in the cloud to handle events and trigger WebHooks

```

- Near-real-time event delivery using 
    1. WebSockets
    2. ServerSentEvents
    x. Not LongPolling
    x. Not HammerPolling

- Fan-out - Subscribe multiple endpoints to the same event to send copies of the event to as many places as needed.

- Massive scale - Supports high-volume workloads with support for millions of events per second. 

- Reliable Delivery - Event Grid will perform an exponential back off for all deliveries. 

Ex: If your WebHook does not return a HTTP 2xx, 
the retry begins immediately. 
When the back off interval reaches one hour, 
retries will be performed every hour. 
After 24 hours, the service will stop attempting to deliver events

```


Event Grid connects can also connect a custom app with other services. 
For example, we can create a custom topic to send your app's event data to Event Grid, 
and take advantage of its reliable delivery, advanced routing, 
and direct integration with Azure and use it in an Azure Function that is created with Webhook Trigger.


![](event-grid-HR.jpg)

<br>
<br>



## DevOps
We can also integrate many details about our Azure services through Event Grid. 
For example when resources are being created or modified. This allows our DevOps team to automate their work, for example by calling a workbook whenever a virtual machine is created, 
automatically adding it to a virtual network and set up security.




## [building-reactive-solution-with-azure-event-grid](https://www.serverless360.com/blog/building-reactive-solution-with-azure-event-grid)



