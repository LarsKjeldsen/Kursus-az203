## Event-Grid vs Service Bus

Event Grid is really about eventing (when an event happen), not enterprise messaging like ServiceBus 
Service Bus is better for financial transactions and workflows --> to handle messaging
Event Grid is for reactive programming in the cloud --> to handle events and trigger WebHooks

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


