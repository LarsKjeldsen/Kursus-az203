 ## Module 5: Designing Cloud Applications for Resiliency



## load balance using traffic manager

script automation for traffic manager 

* https://git.itacademy.dk/cloud/azure-quickstart-templates/tree/master/101-traffic-manager-external-endpoint



##  High Performance ASP.NET 

* Async/Await patter

* State Management 

	* Browser LocalStorage 
	* HTML5 offline mode
	* HTML5 ServiceWorker 
	* HTML5 clientSide JSON databaser 
	* Redis store for sessions/caching/audit/monitor

* Nodejs is much more Scalable for concurrent user than dotnet 





## Cloud patterns

Guidelines and Templates for reuseable solutions. 

"Reuseable means also repeatable"

* Retry pattern at temporary (network-level/unavailability/fault)
	* more code within the catch-block than try-blok 
	* Entity Framework version 6 includes built-in retry pattern
	* Use Observable patterns instead of promise pattern because of retry and cancellation 

* partitioning at data-level [scaling]
	* more architecture than developer focus

*  Valet-key pattern [Azure Storage account]
	* return token/id/resource-path/HATEOS instead of BLOBs for client approval. 
	* The user get access to ressoures using link-pattern 

```
protected images/binaries can be access using SAS (Shared Access Signature ==> token key)

	* https://ms532storage.blob.core.windows.net/<SAS-Token>
	* https://ms532storage.file.core.windows.net/<SAS-Token>
	* https://ms532storage.queue.core.windows.net/<SAS-Token>
	* https://ms532storage.table.core.windows.net/<SAS-Token>

```

Tools available :
		* https://azure.microsoft.com/da-dk/features/storage-explorer/
		* extenstions from Visual Studio: search for Cloud Explorer 



* Redis Cache (Open source Key:value store)
	* origin from https://redis.io/
	* https://stackexchange.github.io/StackExchange.Redis/Basics
	* from nodejs npmjs.org search for redis



